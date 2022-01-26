//
//  webservice.swift
//  CryptoCrazySwiftUIMVVMAsync
//
//  Created by Mac on 25.01.2022.
//

import Foundation
//let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
class webservice {
    
    //this function will not work because asign await keywords are sported on ios 15 later version and xcode 13 latter
    //async and await from 2021 now on.
    //escapin is old tech. async new
    // this throws mean we wont handle here if any error occurs we will handle that on where this function calls.
//    func downloadCurrencyAsync(url:URL) async throws -> [CryptoCurrency]? {
//     let (data,response) = try await URLSession.shared.data(from: url)
//
//    let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
//    return currencies
//    }
    
    // this is also new tech. this function for not async another functions without making them async we can use this func for makin those functions async. And this is also not suported on xcode 12
//    func downloadCurrencyContinuation(url:URL) async throws -> [CryptoCurrency]? {
//    try await withCheckedThrowingContinuation({continuation in
//
//    downloadCurrency(url:url){ result in
//    switch result in
//    case .success(let cryptos):
//    continuation.resume(returning: cryptos ?? [])
//    case .failure(let error)
//    continueation.resume(throwing error)
//
//    }
//
//
//    })
//    }
    //
    //
   
    
    
    func downloadCurrency(url : URL, completion: @escaping (Result<[CryptoCurrency]?,DownloaderError>)-> Void)  {
        //data task uses despatch.global
        URLSession.shared.dataTask(with: url){data,response,error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            guard let data = data , error == nil else {
                // if there is  error;
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                return completion(.failure(.dataParseError))
            }
            completion(.success(currencies))
        }.resume()
    }
}

enum DownloaderError : Error {
    case badUrl
    case noData
    case dataParseError
}
