//
//  ViewModel.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import Combine

class ViewModel {
    let contactsAPI = ContactsAPI()
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        contactsAPI.getContacts().sink { _ in
        } receiveValue: { contacts in
            print(contacts)
        }.store(in: &bag)
    }
}
