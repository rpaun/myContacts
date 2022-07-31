//
//  ContactService.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import Combine

class ContactService {
    private let contactAPI = ContactsAPI()
    
    func getContacts() -> AnyPublisher<[Contact], Error> {
        contactAPI.getContacts()
    }
}
