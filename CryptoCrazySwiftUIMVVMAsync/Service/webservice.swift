//
//  webservice.swift
//  CryptoCrazySwiftUIMVVMAsync
//
//  Created by Mac on 25.01.2022.
//

import Foundation
//let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
class webservice {
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
