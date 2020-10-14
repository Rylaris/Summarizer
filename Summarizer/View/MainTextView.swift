//
//  MainTextView.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/10/14.
//

import UIKit

class MainTextView: UITextView {
    
    override init(frame: CGRect = CGRect.zero, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
