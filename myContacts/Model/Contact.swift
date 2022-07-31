//
//  Contact.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

class Contact: Codable {
    let id: Int
    let name: String
    let gender: Gender
    var phone: String? = nil
    var email: String? = nil
    let active: Bool
    
    init(id: Int,
         name: String,
         gender: Gender,
         phone: String? = nil,
         email: String? = nil,
         active: Bool) {
        self.id = id
        self.name = name
        self.gender = gender
        self.phone = phone
        self.email = email
        self.active = active
    }
}

extension Contact {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func !=(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id != rhs.id
    }
}
