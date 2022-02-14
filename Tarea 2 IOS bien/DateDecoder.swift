//
//  DateFormatter.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 27/1/22.
//

import Foundation

final class DateDecoder: JSONDecoder {
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSSXXX"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
