//
//  APIEndpoint.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//


import Foundation

let baseURL = "https://boringapi.com/api/v1/"

enum APIEndpoint {
    case photos(page: Int, limit: Int, sortBy: String, sortOrder: String)
    
    var path: String  {
        switch self {
        case .photos:
            return "photos"
      
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .photos:
            return HTTPMethod.get
        }
    }
    
    var query: String {
        switch self {
        case .photos(let page, let limit, let sortBy, let sortOrder):
            return "page=\(page)&limit=\(limit)&sort_by=\(sortBy)&sort_order=\(sortOrder)"
        }
    }

}

