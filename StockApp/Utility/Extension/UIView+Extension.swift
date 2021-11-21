//
//  UIView+Extension.swift
//  StockApp
//
//  Created by Nalin Porwal on 21/11/21.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radius: CGFloat = 10, _ maskToBound: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = maskToBound
    }
}
