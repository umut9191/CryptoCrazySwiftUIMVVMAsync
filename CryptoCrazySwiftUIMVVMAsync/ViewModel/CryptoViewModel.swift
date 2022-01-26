//
//  CryptoViewModel.swift
//  CryptoCrazySwiftUIMVVMAsync
//
//  Created by Mac on 26.01.2022.
//

import Foundation
import Combine
import SwiftUI

//@MainActor
class CryptoListViewModel : ObservableObject {
  @Published  var cryptoList = [CryptoViweModel]()
    let web_service = webservice()
    //this func will not work;
//    func downloadCryptosAsync() async {
//    do {
//    let cryptos = await  web_service.downloadCryptos(url:URL)
//    DispatchQueue.main.async{
//self.cryptoList = cryptos.map(CryptoViweModel.init)
//
//        }
//    }catch{
//    print(error)
//    }
//
//    }
    
    //another new tech is Actors ; This is used instead of
    //;  DispatchQueue.main.async
    //usage; by adding at the top of Class @MainActor we are saying that on this class everything works on main thread.
            
                
 
    
    
    
    
    //this func working;
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
