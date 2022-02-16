//
//  APIService.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/25/22.
//

import Foundation

struct APIService {
    
    //MARK: Popular Brands Request
    func fetch10Brands(request: URLRequest?, completion: @escaping(Result<[SellerModel], APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let Brands = try decoder.decode([SellerModel].self, from: data)
                    completion(Result.success(Brands))
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
                
        }.resume()
    }

    //MARK: New Releases Request
    func fetch10Products(request: URLRequest?, completion: @escaping(Result<[ProductModel], APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let Products = try decoder.decode([ProductModel].self, from: data)
                    completion(Result.success(Products))
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    //MARK: Brand Shop Product fetcher Request
    func fetchAllSellerProducts(request: URLRequest?, completion: @escaping(Result<[ProductModel], APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let Products = try decoder.decode([ProductModel].self, from: data)
                    completion(Result.success(Products))
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    //MARK: Create Account Request
    func createAccount(request: URLRequest?, completion: @escaping(Result<String, APIError>) -> Void){
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else {
                completion(Result.success("Account Created!"))
            }
        }.resume()
    }
    
    //MARK: Sign In Request
    func SignIn(request: URLRequest?, completion: @escaping(Result<UserModel, Error>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let user = try decoder.decode(UserModel.self, from: data)
                    completion(Result.success(user))
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    //MARK: FAVORITES REQUESTS
    func getFavorites(request: URLRequest?, completion: @escaping(Result<[ProductModel], APIError>) -> Void){
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let Products = try decoder.decode([ProductModel].self, from: data)
                    completion(Result.success(Products))
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    
    func saveFavorites(request: URLRequest?, completion: @escaping(Result<String, APIError>) -> Void){
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else {
                    completion(Result.success("favorites has been saved!"))
            }
        }.resume()
    }
    
    //MARK: CART REQUESTS
    func saveCart(request: URLRequest?, completion: @escaping(Result<String, APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else {
                    completion(Result.success("Cart Data has been saved"))
            }
        }.resume()
    }
    
    func getCart(request: URLRequest?, completion: @escaping(Result<[ProductModel], APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let Products = try decoder.decode([ProductModel].self, from: data)
                    completion(Result.success(Products))
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    func createOrder(request: URLRequest?, completion: @escaping(Result<String, APIError>) -> Void){
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else {
                    completion(Result.success("Order has been created!"))
            }
        }.resume()
    }
    
    func getOrders(request: URLRequest?, completion: @escaping(Result<[OrderModel], APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let Orders = try decoder.decode([OrderModel].self, from: data)
                    completion(Result.success(Orders))
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    func deleteAccount(request: URLRequest?, completion: @escaping(Result<String, APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else {
                completion(Result.success("Account has been deleted!"))
            }
        }.resume()
    }
    
    func saveShippingAddress(request: URLRequest?, completion: @escaping(Result<String, APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else {
                completion(Result.success("Shipping Info has been saved!"))
            }
        }.resume()
    }
    
    func search(request: URLRequest?, completion: @escaping(Result<SearchModel, APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let searchResults = try decoder.decode(SearchModel.self, from: data)
                    completion(Result.success(searchResults))
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    func getReviews(request: URLRequest?, completion: @escaping(Result<[ReviewModel], APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let reviews = try decoder.decode([ReviewModel].self, from: data)
                    completion(Result.success(reviews))
                    
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    func addReview(request: URLRequest?, completion: @escaping(Result<String, APIError>) -> Void){
        
        guard let request = request else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                
            } else {
                    completion(Result.success("Review has been submitted!"))
            }
        }.resume()
    }
}
