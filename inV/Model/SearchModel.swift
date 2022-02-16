//
//  SearchModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 2/2/22.
//

import Foundation

struct SearchModel: Codable {
    let resultCount: Int
    let brands: [SellerModel]?
    let products: [ProductModel]?
}
