//
//  UIViewController+Extension.swift
//  StockApp
//
//  Created by Nalin Porwal on 18/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let loadingView = UIView()
            loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            loadingView.center = self.view.center
            loadingView.backgroundColor = UIColor.background
            loadingView.alpha = 0.7
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            loadingView.tag = 100
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            spinner.center = CGPoint(x:loadingView.bounds.size.width / 2, y: loadingView.bounds.size.height / 2)
            spinner.color = UIColor.highLightColor
            loadingView.addSubview(spinner)
            self.view.addSubview(loadingView)
            spinner.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            if let loadingView = self.view.viewWithTag(100) {
                loadingView.removeFromSuperview()
            }
        }
    }
}
