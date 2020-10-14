//
//  UIViewController+Alert.swift
//  Summarizer
//
//  Created by 温蟾圆 on 2020/9/25.
//

import UIKit

extension UIViewController {
    /// 在当前视图展示一个alert样式的UIAlertController
    /// - Parameters:
    ///   - title: 展示在UIAlertController顶部的标题
    ///   - message: UIAlertController主体的文字
    ///   - actions: 需要添加到UIAlertController的动作，已有默认的关闭动作，不需要再额外
    ///   添加关闭动作
    ///   - animated: 是否使用动画弹出，默认使用动画
    ///   - completion: 弹出后执行的回调
    func alert(title: String,
               message: String,
               actions: [UIAlertAction] = [],
               animated: Bool = true,
               completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        actions.forEach { alertController.addAction($0) }
        let okAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: animated, completion: completion)
    }
}
