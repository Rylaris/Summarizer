//
//  Sentence.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/9/25.
//

import Foundation

struct Sentence {
    var textRange: NSRange = NSRange(location: 0, length: 0)
    var words: [String] = []
    var index: Int = 0
    var ranking: Int = 0
}
