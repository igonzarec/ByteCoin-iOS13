//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager : CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "CBE1DCDA-0B36-4918-8949-CE635D65E13B"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    //https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=CBE1DCDA-0B36-4918-8949-CE635D65E13B
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        //1. Create a URL
        if let url = URL(string: urlString){
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let coin = self.parseJSON(safeData){
                        self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ coinData : Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let coin = CoinModel(idQuote: decodedData.asset_id_quote, rate: decodedData.rate)
            
            return coin
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

/*
 struct CoinData: Codable {
     let asset_id_quote: String
     let rate: Double
 }
 */
