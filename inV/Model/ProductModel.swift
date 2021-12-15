//
//  ProductModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/11/21.
//

import Foundation

struct ProductModel: Decodable, Identifiable {
    let id: Int
    let ProductImage: String
    let productName: String
    let desc: String
    let category: String
    let price: String
    let countInStock: Int
    let colorway: colorway
}

struct colorway: Decodable {
    let colorName: String
    let hexcode: String
    let mode: String
}
