//
//  ViewController.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/9/24.
//

import UIKit
import Reductio

class ViewController: UIViewController {
    
    lazy var inputTextView = {
        return UITextView()
    }()
    
    lazy var resultTextView = {
        return UITextView()
    }()
    
    lazy var button = {
        return UIButton()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTextView.frame = CGRect(x: 10, y: 10, width: view.frame.width - 20, height: view.frame.height - 20)
        
        resultTextView.text = ""
        
        button.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(popAlert), for: .touchUpInside)
//        view.addSubview(button)
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(popAlert)))
        
//        Reductio.keywords(from: Example.cnText1, count: 5) { words in
//            print(words)
//        }
//
//        Reductio.summarize(text: Example.cnText4, compression: 0.7) { phrases in
//            print(phrases.description)
//            resultTextView.text = phrases.description
//        }
        resultTextView.text = TextRankManager.summarize(of: Example.cnText3, numOfSentences: 3)
        view.addSubview(resultTextView)
    }
    
    @objc func popAlert() {
        let changeBackground1Action = UIAlertAction(title: "红色", style: .default, handler: {_ in
            self.view.backgroundColor = .systemRed
        })
        let changeBackground2Action = UIAlertAction(title: "绿色", style: .default, handler: {_ in
            self.view.backgroundColor = .systemGreen
        })
        let changeBackground3Action = UIAlertAction(title: "黄色", style: .default, handler: {_ in
            self.view.backgroundColor = .systemYellow
        })
        let changeBackground4Action = UIAlertAction(title: "蓝色", style: .default, handler: {_ in
            self.view.backgroundColor = .systemBlue
        })
        self.alert(title: "This is a alert",
                   message: "成功",
                   actions: [changeBackground1Action, changeBackground2Action, changeBackground3Action, changeBackground4Action])
    }


}

extension String {
    func tokenize() -> [String: Int] {
        let word = self
        let tokenize = CFStringTokenizerCreate(kCFAllocatorDefault, word as CFString?, CFRangeMake(0, word.count), kCFStringTokenizerUnitWord, CFLocaleCopyCurrent())
        CFStringTokenizerAdvanceToNextToken(tokenize)
        var range = CFStringTokenizerGetCurrentTokenRange(tokenize)
        var keyWords = [String: Int]()
        let stopWords = StopWords.words
        while range.length > 0 {
            let wRange = word.index(word.startIndex, offsetBy: range.location)..<word.index(word.startIndex, offsetBy: range.location + range.length)
            let keyWord = word.substring(with:wRange)
            if !stopWords.contains(keyWord) {
                keyWords[keyWord] = (keyWords[keyWord] ?? 0) + 1
            }
            CFStringTokenizerAdvanceToNextToken(tokenize)
            range = CFStringTokenizerGetCurrentTokenRange(tokenize)
        }
        
        return keyWords
    }
}
