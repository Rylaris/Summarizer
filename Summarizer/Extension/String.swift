//
//  String+Range.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/9/25.
//

import Foundation
import NaturalLanguage
import CryptoKit

extension String {
    
    var nsRange: NSRange {
        return NSRange(location: 0, length: self.utf8.count)
    }
    
    var range: Range<Self.Index> {
        return self.startIndex..<self.endIndex
    }
    
    var sentence: [Sentence] {
        return []
    }
    
    func sha256(using encoding: String.Encoding = .utf8) -> String {
        let data = self.data(using: encoding)!
        return SHA256.hash(data: data).compactMap { String(format: "%02x", $0) }.joined()
    }
    
    func md5(using encoding: String.Encoding = .utf8) -> String {
        let data = self.data(using: encoding)!
        NSLog("Hello")
        return Insecure.MD5.hash(data: data).compactMap { String(format: "%02x", $0) }.joined()
    }
    
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    subscript(nsrange: NSRange) -> Substring? {
        guard let range = Range(nsrange, in: self) else {
            return nil
        }
        
        return self[range]
    }
}
