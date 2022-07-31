//
//  ContactDetailsViewModel.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation

class ContactDetailsViewModel: BaseViewModel {
    let storage = Services.shared.storage
    
    func saveContact(contact: Contact) {
        storage.saveContact(contact: contact)
    }
    
    func getValidId() -> Int {
        let existentIds = storage.getIdsFromSaveContacts()
        var id: Int = 0
        
        while existentIds.contains(where: { $0 == id}) {
            id = Int.random(in: 0...10000)
        }
        return id
    }
}
