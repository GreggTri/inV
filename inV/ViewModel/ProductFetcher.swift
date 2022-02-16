//
//  ProductFetcher.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/20/22.
//

import Foundation

class ProductFetcher: ObservableObject {
    
    @Published var Products = [ProductModel]()
    @Published var Reviews = [ReviewModel]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func fetch10Products(){
        
        isLoading = true
        errorMessage = nil
        let newestProductsUrl = URL(string: "http://\(preURL):5000/product/newest-products")!
        
        var request = URLRequest(url: newestProductsUrl)
        request.httpMethod = "GET"
        let service = APIService()
        service.fetch10Products(request: request){ [unowned self] result in
            
            DispatchQueue.main.async{
                
                self.isLoading = false
                
                switch result {
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                    
                case .success(let Products):
                    self.Products = Products
                }
            }
        }
    }
    
    func fetchAllSellerProducts(sellerId: String) {
        
        isLoading = true
        errorMessage = nil
        let allSellerProductsUrl = URL(string: "http://\(preURL):5000/product/list-all/\(sellerId)")!
        
        var request = URLRequest(url: allSellerProductsUrl)
        request.httpMethod = "GET"
        let service = APIService()
        service.fetch10Products(request: request){ [unowned self] result in
            
            DispatchQueue.main.async{
                
                self.isLoading = false
                
                switch result {
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                    
                case .success(let Products):
                    self.Products = Products
                }
            }
        }
    }
    func fetchReviews(productId: String){
        
        isLoading = true
        errorMessage = nil
        
        let productReviewsUrl = URL(string: "http://\(preURL):5000/product/get-reviews")!
        let finalBody = try! JSONSerialization.data(withJSONObject: productId)
        
        var request = URLRequest(url: productReviewsUrl)
        request.httpMethod = "GET"
        request.httpBody = finalBody
        
        let service = APIService()
        service.getReviews(request: request){ [unowned self] result in
            
            DispatchQueue.main.async{
                
                self.isLoading = false
                
                switch result {
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                    
                case .success(let reviews):
                    self.Reviews = reviews
                }
            }
        }
    }
    
    func addReview(productId: String, userId: String, reviewContent: String, rating: String){
        
        let addReviewURL = URL(string: "http://\(preURL):5000/user/add-review")!

        let body: [String: Any] = ["productId": productId, "userId": userId, "reviewContent": reviewContent, "rating": rating]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: addReviewURL)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.addReview(request: request){[unowned self] result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let response):
                    print(response)
                }
            }
        }
    }
    
    //MARK: Preview Helpers
    
    static func errorState() -> ProductFetcher {
        let fetcher = ProductFetcher()
        fetcher.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return fetcher
    }
    
    static func successState() -> ProductFetcher {
        let fetcher = ProductFetcher()
        fetcher.Products = [ProductModel.example1()]
        return fetcher
    }
}
