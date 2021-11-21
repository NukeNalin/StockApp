//
//  WishlistViewModel.swift
//  StockApp
//
//  Created by Nalin Porwal on 17/11/21.
//

import Foundation
import Combine

class WishlistViewModel {
    @Published var stockList: [Stock] = []
    var wishlistStock = [String]()
    private var stockEndPoint: String {
        get {
            return wishlistStock.joined(separator: "%2C")
        }
    }
    private var networkSubscriber: AnyCancellable?
    private var timer: Timer?
    init() {
        timer = getStockInLoop()
    }
    
    deinit {
        networkSubscriber?.cancel()
    }
    
    private func getStockInLoop() -> Timer {
        return Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] timer in
            guard let self = self else {return}
            if self.stockEndPoint.isEmpty {
                return
            }
            self.networkSubscriber = Network.downloadWithDecoder(URL(string: "https://api.tickertape.in/stocks/quotes?sids=\(self.stockEndPoint)")!, StockResponse.self)
                .sink(receiveCompletion: { error in
                    // Show Error
                }, receiveValue: { data in
                    self.stockList = data.stockList
                })
        }
    }
    
    func cancelTimer() {
        timer?.invalidate()
    }
    
    func startTimer() {
        timer = getStockInLoop()
    }
    
}
