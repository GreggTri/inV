//
//  ProductModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/11/21.
//

import Foundation

struct ProductModel: Codable{
    let _id: String
    let ProductImage: String
    let productName: String
    let desc: String
    let category: String
    let price: String
    let countInStock: Int
    let colorway: [Colorway]
    let seller: SellerModel
}

struct Colorway: Codable {
    let colorName: String
    let hexcode: String
    let model: String
}

