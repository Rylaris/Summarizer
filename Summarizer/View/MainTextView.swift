//
//  MainTextView.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/10/14.
//

import UIKit

typealias Boolean = Bool

class MainTextView: UITextView {
    
    override init(frame: CGRect = CGRect.zero, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        layer.cornerRadius = 10
        layer.shadowRadius = 10
        layer.shadowOpacity = 1.0
        layer.shadowOffset = .init(width: 5, height: 5)
        layer.shadowColor = UIColor.systemRed.cgColor
        backgroundColor = .secondarySystemBackground
        // 使用AutoLayout必须将该变量置为false
        translatesAutoresizingMaskIntoConstraints = false
        font = .preferredFont(forTextStyle: .body)
        textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
