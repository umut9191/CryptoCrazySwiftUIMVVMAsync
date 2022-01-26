//
//  ContentView.swift
//  CryptoCrazySwiftUIMVVMAsync
//
//  Created by Mac on 25.01.2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var cryptoListModel : CryptoListViewModel
    init(){
        self.cryptoListModel = CryptoListViewModel()
    }
    var body: some View {
        NavigationView{
            List(cryptoListModel.cryptoList,id:\.id){ crypto in
                VStack{
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.black)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                }
               
            
            }
            
//            .toolbar(content: {
//               //// Button(action: {
//                Task.init {
//                    //on button clicked
//                    await cryptoListModel.downloadCryptosAsync(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
//                }, label: {
//                    //btton text
//                    Text("Refresh Button ")
//                })
//            })
            
            
            
            .navigationTitle("Crypto Crazy")
        }.onAppear{
            cryptoListModel.downloadCryptos(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
        // onAppear must be async too and will not work because of versions problems;
//        .task{
//            await cryptoListModel.downloadCryptosAsync(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
//        }
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
