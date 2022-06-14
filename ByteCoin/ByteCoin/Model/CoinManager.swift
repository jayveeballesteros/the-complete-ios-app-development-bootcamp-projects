//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(price: String, currency: String)
    func didFailWithError(error: Error)
}
struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "AFBF3B3E-9561-4229-9B43-4911957232A5"

    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
            
        
        
            let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"

            if let url = URL(string: urlString) {
                
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let safeData = data {
                        let bitcoinPrice = self.parseJSON(safeData)
                        let priceString = String(format: "%.2f", bitcoinPrice!)
                        delegate?.didUpdateCoin(price: priceString, currency: currency)
                    }
                    
                }
                task.resume()
            }
        }
        
        func parseJSON(_ data: Data) -> Double? {
            
            //Create a JSONDecoder
            let decoder = JSONDecoder()
            do {
                
                //try to decode the data using the CoinData structure
                let decodedData = try decoder.decode(CoinData.self, from: data)
                
                //Get the last property from the decoded data.
                let lastPrice = decodedData.rate
                return lastPrice
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
        
    }
