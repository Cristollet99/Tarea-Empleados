//
//  response.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 20/1/22.
//

import Foundation

struct Response: Decodable{
    let status: Int?
    let data: User?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

struct ListResponse: Decodable{
    let status: Int?
    let data: [User]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}
