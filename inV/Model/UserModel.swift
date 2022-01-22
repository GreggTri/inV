//
//  AuthModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/12/21.
//

import Foundation
import CoreData

struct UserModel: Codable{
    let _id: String
    let firstName: String
    let lastName: String
    let email: String
    let shippingInfo: ShippingInfo
    let favorites: Favorite
    let cart: userCart
    let orders: userOrders
}

struct ShippingInfo: Codable {
    let address: String
    let city: String
    let state: String
    let zipCode: String
    
}

struct userOrders: Codable{
    let productId: Int
    let date: String
    let totalPrice: String
}

struct userCart: Codable {
    let productId: Int
    let quantity: Int
    
}

struct Favorite: Codable {
    let productId: Int
}
