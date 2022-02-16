//
//  BrandFetcher.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/20/22.
//

import Foundation
//import SwiftBSON

class BrandFetcher: ObservableObject {
    
    @Published var Brands = [SellerModel]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(){
            
    }
    
    func fetch10Brands(){
        
        isLoading = true
        errorMessage = nil
        
        let popularBrandsUrl = URL(string: "http://\(preURL):5000/seller/popular-brands")
        var request = URLRequest(url: popularBrandsUrl!)
        request.httpMethod = "GET"
        let service = APIService()
        service.fetch10Brands(request: request){ [unowned self] result in
            
            DispatchQueue.main.async{
                
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                    
                case .success(let Brands):
                    self.Brands = Brands
                }
            }
            
        }
    }
    
    //MARK: Preview Helpers
    
    static func errorState() -> BrandFetcher {
        let fetcher = BrandFetcher()
        fetcher.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return fetcher
    }
    
    static func successState() -> BrandFetcher {
        let fetcher = BrandFetcher()
        fetcher.Brands = [SellerModel.example1()]
        return fetcher
    }
}
