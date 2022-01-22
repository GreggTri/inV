//
//  ReviewModel.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/1/22.
//

import Foundation

struct ReviewModel: Codable{
    let _id: String
    let productId: String
    let userId: String
    let dateCreated: String
    let content: String
    let rating: Int
}
