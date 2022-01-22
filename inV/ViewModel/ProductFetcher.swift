//
//  ProductFetcher.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/20/22.
//

import Foundation

class ProductFetcher: ObservableObject {
    
    @Published var Products = [ProductModel]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func fetch10Products(){
        
        isLoading = true
        
        let newestProductsUrl = URL(string: "http://10.182.75.5:5000/product/newest-products")!
        
        var request = URLRequest(url: newestProductsUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) {[unowned self](data, res, error) in
            
            let res = res as? HTTPURLResponse
            
            if res?.statusCode == 200{
                DispatchQueue.main.async{
                    self.isLoading = false
                }
                 
                let decoder = JSONDecoder()
                if let data = data {
                    do{
                        let Products = try decoder.decode(ProductModel.self, from: data)

                        DispatchQueue.main.async{
                            self.Products = [Products]
                        }
                        
                    } catch{
                        print(error)
                    }
                }
            }
            else if res?.statusCode == 400 {
                DispatchQueue.main.async{
                    errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
                }
                print(error!)
            }
            else if res?.statusCode == 500 {
                DispatchQueue.main.async{
                    errorMessage = APIError.unknown.localizedDescription
                }
                print(error!)
            } else {
                DispatchQueue.main.async{
                    errorMessage = APIError.unknown.localizedDescription
                }
                print(error!)
            }
            
            
        }.resume()
    }
    
    func fetchAllSellerProducts(sellerId: String) {
        
        isLoading = true
        print(sellerId)
        let id = sellerId
        print(id)
        let allSellerProductsUrl = URL(string: "http://10.182.75.5:5000/product/list-all/\(id)")!
        
        var request = URLRequest(url: allSellerProductsUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) {[unowned self](data, res, error) in
            
            let res = res as? HTTPURLResponse
            
            if res?.statusCode == 200{
                DispatchQueue.main.async{
                    self.isLoading = false
                }
                 
                let decoder = JSONDecoder()
                if let data = data {
                    do{
                        let Products = try decoder.decode(ProductModel.self, from: data)
                        
                        print(Products)
                        
                        DispatchQueue.main.async{
                            self.Products = [Products]
                        }
                        
                    } catch{
                        print(error)
                    }
                }
            }
            else if res?.statusCode == 400 {
                DispatchQueue.main.async{
                    errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
                }
                print(error!)
            }
            else if res?.statusCode == 500 {
                DispatchQueue.main.async{
                    errorMessage = APIError.unknown.localizedDescription
                }
                print(error!)
            } else {
                DispatchQueue.main.async{
                    errorMessage = APIError.unknown.localizedDescription
                }
                print(error!)
            }
            
            
        }.resume()
    }
}
