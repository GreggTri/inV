//
//  BrandFetcher.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/20/22.
//

import Foundation

class BrandFetcher: ObservableObject {
    
    @Published var Brands = [SellerModel]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(){
            
    }
    
    func fetch10Brands(){
        
        isLoading = true
        
        guard let popularBrandsUrl = URL(string: "http://10.182.75.5:5000/seller/popular-brands") else {
            errorMessage = APIError.badURL.localizedDescription
            return
        }
        
        var request = URLRequest(url: popularBrandsUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) {[unowned self](data, res, error) in
            
            let res = res as? HTTPURLResponse
            let error = error
            if res?.statusCode == 200{
                DispatchQueue.main.async{
                    self.isLoading = false
                }
                 
                let decoder = JSONDecoder()
                if let data = data {
                    do{
                        let Brands = try decoder.decode(SellerModel.self, from: data)

                        DispatchQueue.main.async{
                            self.Brands = [Brands]
                        }
                        
                    } catch{
                        DispatchQueue.main.async{
                            errorMessage = APIError.unknown.localizedDescription
                        }
                        print(error)
                    }
                }
            }
            else if res?.statusCode == 400 {
                DispatchQueue.main.async{
                    errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
                }
                print(error ?? "")
            }
            else if res?.statusCode == 500 {
                DispatchQueue.main.async{
                    errorMessage = APIError.unknown.localizedDescription
                }
                print(error ?? "")
            } else {
                DispatchQueue.main.async{
                    errorMessage = APIError.unknown.localizedDescription
                }
                print(error ?? "")
            }
            
            
        }.resume()
    }
}
