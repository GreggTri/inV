//
//  SellerModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/1/22.
//

import Foundation

struct SellerModel: Codable {
    let id: String
    let brandLogo: String
    let brandName: String
    let customerService: CustomerService
    let numOfProducts: Int?
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case brandLogo = "brandLogo"
        case brandName = "brandName"
        case customerService = "customerService"
        case numOfProducts = "numOfProducts"
    }
    
    static func example1() -> SellerModel{
        return SellerModel(id: "1603ef61d0126fd6", brandLogo: "tingy.png", brandName: "Trimarchi", customerService: CustomerService(csEmail: "support@trimarchi.com", csPhone: "2034828850", returnPolicy: "60 days from the day the product was delivered", warrantyPolicy: "1 year warranty policy"), numOfProducts: 2)
    }
}


struct CustomerService: Codable {
    let csEmail: String
    let csPhone: String
    let returnPolicy: String
    let warrantyPolicy: String
    
    enum CodingKeys: String, CodingKey {
        case csEmail = "email"
        case csPhone = "phoneNumber"
        case returnPolicy = "return_policy"
        case warrantyPolicy = "warranty_policy"
    }
}

