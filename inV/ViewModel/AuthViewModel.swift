//
//  AuthViewModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/15/21.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {

    @Published var user: UserModel!
    @Published var Products = [ProductModel]()
    @Published var orders = [OrderModel]()
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    
    func createAccount(firstName: String, lastName: String, email: String, password: String ) {
        
        errorMessage = nil
        let createAccountUrl = URL(string: "http://\(preURL):5000/user/")!
        let body: [String: String] = ["firstName": firstName, "lastName": lastName, "email": email, "password": password]
        
        //NOT GOOD FOR PRODUCTION - search "JSON serialization error handling"
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: createAccountUrl)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.createAccount(request: request){ [unowned self] result in
            
            DispatchQueue.main.async{
                
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
    
    func SignIn(email: String, password: String) {
        
        
        errorMessage = nil
        let signInUrl = URL(string: "http://\(preURL):5000/user/login")!
        let body: [String: String] = ["email": email, "password": password]
        
        //NOT GOOD FOR PRODUCTION - search "JSON serialization error handling"
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: signInUrl)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.SignIn(request: request){ [unowned self] result in
            
            DispatchQueue.main.async{
                
                switch result {
                    
                case .failure(let error):
                    
                    if error.localizedDescription == "400"{
                        self.errorMessage = "Wrong email or password. Please try again"
                        self.isAuthenticated = false
                    } else {
                        self.errorMessage = "Oops! something went wrong. Please try again"
                        self.isAuthenticated = false
                        
                    }
                    print(error)
                    
                case .success(let user):
                    self.isAuthenticated = true
                    self.user = user
                    print(user)
                }
            }
        }
    }
    
    //MARK: FAVORITES FUNCTIONALITY
    func getFavorites(){
        
        isLoading = true
        errorMessage = nil
        let favoritesURL = URL(string: "http://\(preURL):5000/user/favorites")!
        
        let body = try! JSONSerialization.data(withJSONObject: user.favorites)
        
        var request = URLRequest(url: favoritesURL)
        request.httpMethod = "GET"
        request.httpBody = body
        let service = APIService()
        service.getFavorites(request: request){[unowned self] result in
            
            DispatchQueue.main.async {
                
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
    
    func addFavorites(productId: String){
        
        objectWillChange.send()
        let fp = favoriteProduct(productId: productId)
        user.favorites.append(fp)
        saveFavorites()
    }
    
    func removeFavorites(productId: String){
        
        objectWillChange.send()
        if let index:Int = user.favorites.firstIndex(where: {$0.productId == productId}) {
            user.favorites.remove(at: index)
        }
        saveFavorites()
    }
    
    func saveFavorites(){
        errorMessage = nil
        let savefavoritesURL = URL(string: "http://\(preURL):5000/user/save-favorites")!
        let body: [String: Any] = ["userId": user.id, "favorites": user.favorites]
        
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: savefavoritesURL)
        request.httpMethod = "PATCH"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.saveFavorites(request: request){[unowned self] result in
            
            DispatchQueue.main.async {
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
    
    //MARK: ADD TO CART FUNCTIONALITY
    func addCart(productId: String, colorwayName: String){
        
        objectWillChange.send()
        let arr = userCart(productId: productId, colorwayName: colorwayName ,quantity: 1)
        user.cart.append(arr)
        saveCart()
    }
    
    func addQuantityToItem(productId: String){
        objectWillChange.send()
        if let index:Int = user.cart.firstIndex(where: {$0.productId == productId}) {
            user.cart[index].quantity += 1
        }
        saveCart()
    }
    
    func getQuantity(productId: String) -> Int{
        if let index:Int = user.cart.firstIndex(where: {$0.productId == productId}) {
            return user.cart[index].quantity
        } else {
            return 1
        }
    }
    
    func minusQuantityToItem(productId: String){
        objectWillChange.send()
        if let index:Int = user.cart.firstIndex(where: {$0.productId == productId}) {
            user.cart[index].quantity -= 1
        }
        saveCart()
    }
    
    func getColowayName(productId: String) -> String{
        if let index:Int = user.cart.firstIndex(where: {$0.productId == productId}) {
            return user.cart[index].colorwayName
        } else {
            return "Colorway Not Found"
        }
    }
    
    func removeCart(productId: String){
        
        objectWillChange.send()
        if let index:Int = user.cart.firstIndex(where: {$0.productId == productId}) {
            user.cart.remove(at: index)
        }
        saveCart()
    }
    
    func removeAllCart(){
        
        objectWillChange.send()
        user.cart.removeAll()
        saveCart()
    }
    
    //MARK: TODO:: Make request in APIService
    func saveCart(){
        
        errorMessage = nil
        
        let saveCartURL = URL(string: "http://\(preURL):5000/user/save-cart")!
        
        let body: [String: Any] = ["userId": user.id, "cart": user.cart]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: saveCartURL)
        request.httpMethod = "PATCH"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.saveCart(request: request){[unowned self] result in
            
            DispatchQueue.main.async {
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
    
    func getCart() {
        
        isLoading = true
        errorMessage = nil
        
        let saveCartURL = URL(string: "http://\(preURL):5000/user/cart")!
        let finalBody = try! JSONSerialization.data(withJSONObject: user.cart)
        
        var request = URLRequest(url: saveCartURL)
        request.httpMethod = "GET"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.getCart(request: request){[unowned self] result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let product):
                    self.Products = product
                }
            }
        }
    }
    
    func getOrders(userId: String){
        isLoading = true
        errorMessage = nil
        
        let saveCartURL = URL(string: "http://\(preURL):5000/user/view-orders")!
        let finalBody = try! JSONSerialization.data(withJSONObject: userId)
        
        var request = URLRequest(url: saveCartURL)
        request.httpMethod = "GET"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.getOrders(request: request){[unowned self] result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let Orders):
                    self.orders = Orders
                }
            }
        }
    }
    
    func logout(){
        
        objectWillChange.send()
        self.isAuthenticated = false;
    }
    
    func deleteAccount(userId: String){
        
        isLoading = true
        errorMessage = nil
        
        let deleteAccountURL = URL(string: "http://\(preURL):5000/user/delete-user")!
        let finalBody = try! JSONSerialization.data(withJSONObject: userId)
        
        var request = URLRequest(url: deleteAccountURL)
        request.httpMethod = "DELETE"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.deleteAccount(request: request){[unowned self] result in
            
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
    
    func addShippingInfo(street: String, city: String, state: String, zipcode: String){
        objectWillChange.send()
        let info = ShippingInfo(street: street, city: city, state: state, zipCode: zipcode)
        user.shippingInfo = info
        saveShippingAddress()
    }
    
    func saveShippingAddress(){
        errorMessage = nil
        
        let saveAddressURL = URL(string: "http://\(preURL):5000/user/save-address")!
        let body: [String: Any] = ["userId": user.id, "address": user.shippingInfo!]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: saveAddressURL)
        request.httpMethod = "PATCH"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let service = APIService()
        service.saveShippingAddress(request: request){[unowned self] result in
            
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
    
    
}
