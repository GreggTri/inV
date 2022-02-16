//
//  AuthModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import Foundation

struct UserModel: Codable{
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    var shippingInfo: ShippingInfo?
    var favorites: [favoriteProduct]
    var cart: [userCart]
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case shippingInfo = "address"
        case favorites = "favorites"
        case cart = "cart"
    }
}

struct ShippingInfo: Codable {
    let street: String
    let city: String
    let state: String
    let zipCode: String
    
    enum CodingKeys: String, CodingKey{
        case street = "street"
        case city = "city"
        case state = "state"
        case zipCode = "zipCode"
    }
}

struct userCart: Codable {
    let productId: String
    let colorwayName: String
    var quantity: Int
    
    enum CodingKeys: String, CodingKey{
        case productId = "product_id"
        case colorwayName = "colorwayName"
        case quantity = "quantity"
        
    }
    
}

struct favoriteProduct: Codable {
    let productId: String
    
    enum CodingKeys: String, CodingKey{
        case productId = "product_id"
    }
}
