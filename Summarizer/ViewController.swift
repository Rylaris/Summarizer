//
//  ViewController.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/9/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var inputTextView = {
        return MainTextView()
    }()
    
    lazy var resultTextView = {
        return MainTextView()
    }()
    
    lazy var button = {
        return UIButton()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(inputTextView)
        inputTextView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(200)
            $0.width.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(resultTextView)
        resultTextView.snp.makeConstraints {
            $0.top.equalTo(inputTextView.snp.bottom).offset(40)
            $0.height.equalTo(200)
            $0.width.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
        }
    }
}
