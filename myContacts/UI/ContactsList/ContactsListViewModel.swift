//
//  ContactsListViewModel.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import Combine

class ContactsListViewModel: BaseViewModel {
    //private let contactsService = Services.shared.contact
    private let storageService = Services.shared.storage
    
    var contacts = CurrentValueSubject<[Contact], Never>([])
    
    required init() {
        super.init()
        storageService.contacts.sink { [weak self] contacts in
            self?.contacts.send(contacts)
            self?.state.send(.idle)
        }.store(in: &bag)
    }
    
    func getContacts() {
        storageService.getContacts()
    }
}
