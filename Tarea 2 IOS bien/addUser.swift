//
//  addUser.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 21/1/22.
//

import Foundation


struct AddUser: Encodable{
    
    let name: String?
    let email: String?
    let password: String?
    let Workstation: String?
    let salary: Int?
    let biography: String?
    let created_at: Date?
    let updated_at: Date?
}
