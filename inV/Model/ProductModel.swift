//
//  ProductModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/11/21.
//

import Foundation

struct ProductModel: Codable{
    let id: String
    let productImage: String
    let productName: String
    let desc: String
    let category: String
    let price: String
    let countInStock: Int
    let avgRating: String
    let colorway: [Colorway]
    let seller: SellerModel
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case productImage = "productImage"
        case productName = "productName"
        case desc = "desc"
        case category = "category"
        case price = "price"
        case countInStock = "countInStock"
        case avgRating = "avgRating"
        case colorway = "colorway"
        case seller = "seller"
    }
    
    static func example1() -> ProductModel {
        return ProductModel(id: "17821381g18dva1", productImage: "something.png", productName: "Trimarchi sunglasses", desc: "chill bro these sunglasses are too hot", category: "Sunglasses", price: "350", countInStock: 300, avgRating: "4.5", colorway: [Colorway(colorName: "white", hexcode: "#fff", model: "someothermodel.usdz"), Colorway(colorName: "black", hexcode: "#000", model: "somemodel.usdz")], seller: SellerModel.example1())
    }
}

struct Colorway: Codable {
    let colorName: String
    let hexcode: String
    let model: String
    
    enum CodingKeys: String, CodingKey{
        case colorName = "colorName"
        case hexcode = "hexcode"
        case model = "model"
    }
}

