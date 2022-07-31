//
//  StorageService.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import CoreData
import Combine
import UIKit

class StorageService {
    private let contactsService = ContactsAPI()
    
    var contacts = CurrentValueSubject<[Contact], Never>([])
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        setContacts()
    }
    
    private func saveContacts(contacts: [Contact]) {
        let data = try! JSONEncoder().encode(contacts)
        UserDefaults.standard.setValue(data, forKey: "contacts")
    }
    
    private func getSavedContacts() -> [Contact] {
        let data = UserDefaults.standard.data(forKey: "contacts")
        if let data = data {
            let contacts = try! JSONDecoder().decode([Contact].self, from: data)
            return contacts
        }
        return []
    }
    
    func getIdsFromSaveContacts() -> [Int] {
        return getSavedContacts().map { contact -> Int in
            return contact.id
        }
    }
    
    func saveContact(contact: Contact) {
        var savedContacts = getSavedContacts()
        savedContacts.append(contact)
        saveContacts(contacts: savedContacts)
    }
    
    func getContacts() {
        contacts.send(getSavedContacts())
    }
    
    private func setContacts() {
        contactsService.getContacts().sink { _ in
        } receiveValue: { [weak self] apicontacts in
            guard let self = self else { return }
            var savedContacts = self.getSavedContacts()
            apicontacts.forEach { apiContact in
                if !savedContacts.contains(where: { $0.id == apiContact.id }) {
                    savedContacts.append(apiContact)
                }
            }
            self.saveContacts(contacts: savedContacts)
        }.store(in: &bag)
    }
}


