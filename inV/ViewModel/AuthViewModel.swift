//
//  AuthViewModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/15/21.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    //@Published var NewAccount: [NewAccountModel] = []
    //@Published var UserAuth: [AuthModel] = []
    @Published var isAuthenticated: Bool = true
    
    let createAccountUrl = URL(string: "http://10.182.75.5:5000/user/")!
    let signInUrl = URL(string: "http://10.182.75.5:5000/user/login")!
    
    func createAccount(firstName: String, lastName: String, email: String, password: String ) {
        
        let body: [String: String] = ["firstName": firstName, "lastName": lastName, "email": email, "password": password]
        
        //NOT GOOD FOR PRODUCTION - search "JSON serialization error handling"
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: createAccountUrl)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {(data, res, err) in
            
            if let response = res as? HTTPURLResponse, response.statusCode == 500 {
                print("Server Error, Please Try Again...")
            }
            
            if let response = res as? HTTPURLResponse, response.statusCode == 400 {
                print("This email is already being used with a different account")
            }
            
            if let response = res as? HTTPURLResponse, response.statusCode == 201 {
                print("Your account has been created!")
            }
            
        }.resume()
    }
    
    func SignIn(email: String, password: String) {
        
        
        
        let body: [String: String] = ["email": email, "password": password]
        
        //NOT GOOD FOR PRODUCTION - search "JSON serialization error handling"
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: signInUrl)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {(data, res, err) in
                    
            if let response = res as? HTTPURLResponse, response.statusCode == 500 {
                print("Server Error, Please Try Again...")
                DispatchQueue.main.async {
                    self.isAuthenticated = false

                }
            }
            
            if let response = res as? HTTPURLResponse, response.statusCode == 400 {
                print("Email or password is incorrect. Please try again...")
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                }
            }
            
            if let response = res as? HTTPURLResponse, response.statusCode == 200 {
                print("You have successfully logged in")
                
                DispatchQueue.main.async{
                    self.isAuthenticated = true
                }
                
            } else {
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                }
            }
            
        }.resume()
    }
    
    func Authenticated() -> Bool{
        return self.isAuthenticated
    }
}
