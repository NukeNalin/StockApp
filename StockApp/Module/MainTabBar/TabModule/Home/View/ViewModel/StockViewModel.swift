//
//  StockViewModel.swift
//  StockApp
//
//  Created by Nalin Porwal on 16/11/21.
//

import Foundation
import Combine

class StockViewModel {
    
   @Published var stockList: [Stock] = []
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
            self.networkSubscriber = Network.downloadWithDecoder(URL(string: "https://api.tickertape.in/stocks/quotes?sids=RELI%2CTCS%2CITC%2CHDBK%2CINFY")!, StockResponse.self)
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
