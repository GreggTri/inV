//
//  OrderModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/31/22.
//

import Foundation

struct OrderModel: Codable{
    let id: String
    let userId: String
    let orderedProduct: productInOrder
    let address: ShippingInfo
    let purchaseDate: Date
    let trackingId: String
    let status: String
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case userId = "user"
        case orderedProduct = "product"
        case address = "address"
        case purchaseDate = "createdAt"
        case trackingId = "trackingId"
        case status = "status"
    }
       
}

struct productInOrder: Codable {
    let productId: String
    let productImage: String
    let productName: String
    let colorName: String
    let purchasePrice: String
    let quantity: String
    
    enum CodingKeys: String, CodingKey{
        case productId = "productId"
        case productImage = "productImage"
        case productName = "productName"
        case colorName = "colorwayName"
        case purchasePrice = "price"
        case quantity = "quantity"
    }
}
