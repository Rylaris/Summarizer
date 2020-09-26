//
//  String+Range.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/9/25.
//

import Foundation

extension String {
    var nsRange: NSRange {
        return NSRange(location: 0, length: self.utf16.count)
    }
    
    var range: Range<Self.Index> {
        return self.startIndex..<self.endIndex
    }
    
    subscript(nsrange: NSRange) -> Substring? {
        guard let range = Range(nsrange, in: self) else {
            return nil
        }
        return self[range]
    }
}
