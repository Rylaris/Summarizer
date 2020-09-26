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
    
    static func summarize(of text: String, numOfSentences n: Int) -> String {
        
        var sentences: [Sentence] = []
        var wordFrequencies: [String: Int] = [:]
        
        let stopWords = StopWords.words
        
        let sentenceTokenizer = NLTokenizer(unit: .sentence)
        sentenceTokenizer.string = text
        sentenceTokenizer.enumerateTokens(in: text.range) { tokenRangeOfSentence, _ in
            let s = String(text[tokenRangeOfSentence])
            let from = tokenRangeOfSentence.lowerBound.samePosition(in: text.utf16)
            let to = tokenRangeOfSentence.upperBound.samePosition(in: text.utf16)
            let nsRange = NSRange(location: text.utf16.distance(from: text.utf16.startIndex, to: from!), length: text.utf16.distance(from: from!, to: to!))
            var sentence = Sentence()
            sentence.textRange = nsRange
            sentence.index = sentences.count
            let wordTokenizer = NLTokenizer(unit: .word)
            wordTokenizer.string = s
            wordTokenizer.enumerateTokens(in: s.range, using: { tokenRangeOfWord, _ in
                let word = s[tokenRangeOfWord].lowercased()
                if !stopWords.contains(word) {
                    wordFrequencies[word, default: 0] += 1
                    sentence.words.append(word)
                }
                return true
            })
            sentences.append(sentence)
            return true
        }
        
        
        
        for i in sentences.indices {
            sentences[i].ranking = sentences[i].words.reduce(0, { (rank, word) -> Int in
                rank + wordFrequencies[word, default: 0]
            })
        }
        
        // Sort Sentences by ranking
        let sentencesByRanking = sentences.sorted { $0.ranking > $1.ranking }
        
        // Select the most important sentences
        let keySentences = sentencesByRanking.prefix(n).sorted { $0.index < $1.index }
        
        // Build Summary based on the most important sentences
        var summary = ""
        var firstSentence = true
        for sentence in keySentences {
            guard let text = text[sentence.textRange] else {
                continue
            }
            
            if firstSentence {
                firstSentence = false
            } else {
                summary.append(" ")
            }
            
            summary.append(text.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        return summary
    }
}
