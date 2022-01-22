//
//  SellerModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/1/22.
//

import Foundation

struct SellerModel: Codable {
    let _id: String
    let brandLogo: String
    let brandName: String
    let customerService: CustomerServiceInSeller
    let numOfProducts: Int
    
}

struct CustomerServiceInSeller: Codable {
    let cs_email: String
    let cs_phone: String
    let return_policy: String
    let warranty_policy: String
}

