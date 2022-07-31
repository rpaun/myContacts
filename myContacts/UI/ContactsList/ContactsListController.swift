//
//  ContactsListController.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import UIKit

class ContactsListController: BaseViewController<ContactsListViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var contacts: [Contact] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getContacts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.contacts.sink { _ in
        } receiveValue: { [weak self] contacts in
            self?.contacts = contacts
            self?.tableView.reloadData()
        }.store(in: &bag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let dest = segue.destination as! ContactDetailsController
            dest.contact = sender as? Contact
        }
    }
}

extension ContactsListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactCell
        cell.load(contact: contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetails", sender: contacts[indexPath.row])
    }
}
