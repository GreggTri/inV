//
//  APIError.swift
//  inV
//
//  Created by Gregg Trimarchi on 1/20/22.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        // user feedback
        switch self {
        case .badURL, .parsing, .unknown:
            return "Sorry! something went wrong."
        case .badResponse(let statusCode):
            if statusCode == 400 {
                return "400"
            }else {
                return "Sorry! the connection to our server failed."
            }
        case .url(let error):
            return error?.localizedDescription ?? "Oh no! Something went wrong."
        }
    }
    
    var description: String {
        //info for debugging
        switch self {
        case .unknown: return "unknown error"
        case .badURL: return "invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
    }
}
