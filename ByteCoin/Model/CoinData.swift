//
//  CoinData.swift
//  ByteCoin
//
//  Created by Ivan Gonzalez on 17/09/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

/*
 {
   "time": "2022-09-17T18:30:57.0000000Z",
   "asset_id_base": "BTC",
   "asset_id_quote": "USD",
   "rate": 20068.117466996891441251969711
 }
 */

import Foundation

struct CoinData: Codable {
    let asset_id_quote: String
    let rate: Double
}
