//
//  StockCell.swift
//  StockApp
//
//  Created by Nalin Porwal on 16/11/21.
//

import UIKit

class StockCell: UICollectionViewCell {

    @IBOutlet weak var imageViewFav: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelStockPrice: UILabel!
    @IBOutlet weak var labelLow: UILabel!
    @IBOutlet weak var labelHigh: UILabel!
    @IBOutlet weak var labelPriceChanges: UILabel!
    var tapGesture = UITapGestureRecognizer()
    var favCallBack: ()->Void = {}
    
    var isInWishList: Bool? = nil {
        didSet {
            if let isInWishList = isInWishList {
                self.imageViewFav.image = UIImage(systemName: isInWishList ? "star.fill" : "star")
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tapGesture.addTarget(self, action: #selector(didTapOnCell(_:)))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc func didTapOnCell(_ sender: UITapGestureRecognizer) {
        favCallBack()
    }
    
    func setUpData(_ stock: Stock) {
        labelStockPrice.text = "₹\(stock.price)"
        labelName.text = stock.id
        labelPriceChanges.text = "\(stock.change > 0 ? "+" : "")\(stock.change)"
        labelLow.text = "\(stock.low)"
        labelHigh.text = "\(stock.high)"
        labelPriceChanges.textColor = stock.change > 0 ? .green : .red
    }
        
    override func prepareForReuse() {
        labelStockPrice.text = ""
        labelName.text = ""
        labelPriceChanges.text = ""
        labelLow.text = ""
        labelHigh.text = ""
    }
}

