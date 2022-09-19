//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.rateString
            self.currencyLabel.text = coin.idQuote
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

/*
 UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate
 */

//MARK: - UIPickerViewDataSource
extension CoinViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

//MARK: - UIPickerViewDelegate
extension CoinViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency: String = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
}

//MARK: - CoinManagerDelegate
extension CoinViewController : CoinManagerDelegate {
    
}
