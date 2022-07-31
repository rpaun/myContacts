//
//  ContactsAPI.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import SwiftyJSON
import Combine

class ContactsAPI {
    let client = APIClient.shared
    
    func getContacts() -> AnyPublisher<[Contact], Error> {
        return client.GET(endpoint: .v2(endpoint: "/users")) { json in
            return json.arrayValue.map { item in
                Contact(id: item["id"].intValue,
                        name: item["name"].stringValue,
                        gender:  .init(rawValue: item["gender"].stringValue) ?? .male,
                        active: item["status"].stringValue == "active")
            }.filter({$0.active})
        }
    }
}
