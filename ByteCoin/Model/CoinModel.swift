//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Ivan Gonzalez on 17/09/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let idQuote: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.1f", rate)
    }
}

