//
//  MainViewController.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/9/24.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var inputTextView = {
        return MainTextView()
    }()
    
    lazy var resultTextView = {
        return MainTextView()
    }()
    
    lazy var summarizerButton = {
        return UIButton(type: .custom)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(resignResponder))
        view.addGestureRecognizer(recognizer)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(pushSettingViewController))
        
        do {
            view.addSubview(inputTextView)
            inputTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            inputTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            inputTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
            inputTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
            inputTextView.text = "请输入需要摘要的文本"
            inputTextView.textColor = .secondaryLabel
            inputTextView.delegate = self
            inputTextView.layer.cornerRadius = 10
        }
        
        do {
            summarizerButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(summarizerButton)
            summarizerButton.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 25).isActive = true
            summarizerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            summarizerButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
            summarizerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            summarizerButton.backgroundColor = .systemBlue
            summarizerButton.layer.cornerRadius = 25
            let config = UIImage.SymbolConfiguration(pointSize: summarizerButton.layer.cornerRadius * 2 / 3)
            summarizerButton.setImage(UIImage(systemName: "scissors")?.applyingSymbolConfiguration(config), for: .normal)
            summarizerButton.imageView?.tintColor = .white
            summarizerButton.addTarget(self, action: #selector(summarize), for: .touchUpInside)
        }
        
        
        do {
            view.addSubview(resultTextView)
            resultTextView.topAnchor.constraint(equalTo: summarizerButton.bottomAnchor, constant: 25).isActive = true
            resultTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
            resultTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
            resultTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
            resultTextView.isEditable = false
            resultTextView.textColor = .label
            let recognizer = UITapGestureRecognizer(target: self, action: nil)
            resultTextView.addGestureRecognizer(recognizer)
        }
        
        
    }
    
    @objc func resignResponder() {
        inputTextView.resignFirstResponder()
    }
    
    @objc func pushSettingViewController() {
        let controller = SetttingViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func summarize() {
        guard inputTextView.textColor != .secondaryLabel else {
            return
        }
        resultTextView.text = TextRankManager.summarize(of: inputTextView.text, numOfSentences: 3).joined()
    }
    
    @objc func presentResult() {
        
    }
}

extension MainViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .secondaryLabel {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "请输入需要摘要的文本"
            textView.textColor = .secondaryLabel
        }
    }
}
