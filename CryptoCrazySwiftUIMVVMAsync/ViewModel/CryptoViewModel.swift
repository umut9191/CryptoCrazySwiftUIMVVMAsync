//
//  CryptoViewModel.swift
//  CryptoCrazySwiftUIMVVMAsync
//
//  Created by Mac on 26.01.2022.
//

import Foundation
import Combine
import SwiftUI


class CryptoListViewModel : ObservableObject {
  @Published  var cryptoList = [CryptoViweModel]()
    let web_service = webservice()
    func downloadCryptos(url : URL){
        web_service.downloadCurrency(url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cryptoes):
                if let cryptos = cryptoes {
                    
                    DispatchQueue.main.async{
            self.cryptoList = cryptos.map(CryptoViweModel.init)
                    
                        }
                    
                }
            }
        }
    }
}


struct CryptoViweModel {
    let crypto : CryptoCurrency
    
    var id : UUID?{
        crypto.id
    }
    var currency : String {
        crypto.currency
    }
    var price : String{
        crypto.price
    }
}
