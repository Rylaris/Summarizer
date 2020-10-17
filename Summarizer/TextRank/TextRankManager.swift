//
//  TextRankManager.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/9/25.
//

import Foundation
import NaturalLanguage

class TextRankManager {
    private init() {}
}

extension TextRankManager {
    
    static func summarize(of text: String, numOfSentences n: Int) -> [String] {
        
        var sentences: [Sentence] = []
        var wordFrequencies: [String: Int] = [:]
        
        let stopWords = StopWords.words
        
        enumerate(of: text, unit: .sentence, using: { tokenRangeOfSentence, _ in
            let s = String(text[tokenRangeOfSentence])
            let from = tokenRangeOfSentence.lowerBound.samePosition(in: text.utf16)
            let to = tokenRangeOfSentence.upperBound.samePosition(in: text.utf16)
            let nsRange = NSRange(location: text.utf16.distance(from: text.utf16.startIndex, to: from!), length: text.utf16.distance(from: from!, to: to!))
            
            var sentence = Sentence()
            sentence.textRange = nsRange
            sentence.index = sentences.count
            
            enumerate(of: s, unit: .word, using: { tokenRangeOfWord, _ in
                let word = s[tokenRangeOfWord].lowercased()
                
                if !stopWords.contains(word) {
                    wordFrequencies[word, default: 0] += 1
                    sentence.words.append(word)
                }
                
                return true
            })
            
            sentences.append(sentence)
            return true
        })
        
        for i in sentences.indices {
            sentences[i].ranking = sentences[i].words.reduce(0, { (rank, word) -> Int in
                return rank + wordFrequencies[word, default: 0]
            })
        }
        
        // 按照权重降序排列
        let sentencesByRanking = sentences.sorted { $0.ranking > $1.ranking }
        
        // 选出权重最高的n个句子按出现顺序排列
        let keySentences = sentencesByRanking.prefix(n).sorted { $0.index < $1.index }
        
        var result = [String]()
        for sentence in keySentences {
            guard let text = text[sentence.textRange] else {
                continue
            }
            result.append(String(text))
        }
        
        return result
    }
    
    
    static func enumerate(of text: String, unit: NLTokenUnit, using block: (Range<String.Index>, NLTokenizer.Attributes) -> Bool) {
        let wordTokenizer = NLTokenizer(unit: unit)
        wordTokenizer.string = text
        wordTokenizer.enumerateTokens(in: text.range, using: block)
    }
}
