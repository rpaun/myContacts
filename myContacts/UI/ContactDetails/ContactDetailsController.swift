//
//  ContactDetailsController.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import UIKit

class ContactDetailsController: BaseViewController<ContactDetailsViewModel>  {
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var bottomButton: UIButton!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomButton.setTitle(contact == nil ? "Save" : "Update", for: .normal)
        initField()
    }
    
    private func initField() {
        var nameSplit = contact?.name.split(separator: " ")
        lastnameField.text = String(nameSplit?.removeFirst() ?? "")
        firstnameField.text = String(nameSplit?.removeFirst() ?? "")
        phoneField.text = contact?.phone ?? ""
        emailField.text = contact?.email ?? ""
    }
    
    private func saveContact(firstname: String, lastname: String, phone: String?, email: String?) {
        let id = viewModel.getValidId()
        let contact = Contact(id: id,
                              name: "\(firstname) \(lastname)",
                              gender: .male,
                              phone: phone,
                              email: email,
                              active: true)
        viewModel.saveContact(contact: contact)
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func areFieldValid() -> Bool {
        if firstnameField.text!.isEmpty || lastnameField.text!.isEmpty {
            alert(title: "Ups", message: "First name and last name are mandatory")
            return false
        } else if !phoneField.text!.isEmpty {
            let phone = phoneField.text!
            if !phone.hasPrefix("07") || phone.count != 10 {
                alert(title: "Ups", message: "Phone invalid format")
                return false
            }
            return true
        }
        return true
    }
    
    @IBAction func onSavePressed(_ sender: UIButton) {
        if areFieldValid() {
            viewModel.saveContact(contact: Contact(id: viewModel.getValidId(),
                                                   name: "\(firstnameField.text!) \(lastnameField.text!)",
                                                   gender: .male,
                                                   active: true))
            navigationController?.popViewController(animated: true)
        }
    }
}
