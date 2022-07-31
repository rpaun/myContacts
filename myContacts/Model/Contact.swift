//
//  Contact.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation

enum Gender {
    case female
    case male
}

struct Contact {
    let id: Int
    let name: String
    let gender: Gender
    let active: Bool
}
