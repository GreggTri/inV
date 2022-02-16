//
//  ReviewModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/1/22.
//

import Foundation

struct ReviewModel: Codable{
    let id: String
    let productId: String
    let userFirstName: String
    let userLastName: String
    let dateCreated: String
    let content: String
    let rating: Double
}
