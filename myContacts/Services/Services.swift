//
//  Services.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation

class Services {
    
    static let shared = Services()
    
    let contact = ContactService()
    let storage = StorageService()
    
    private init() {}
}
