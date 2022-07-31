//
//  ContactCell.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import UIKit
import Kingfisher

class ContactCell: UITableViewCell {
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var initialsContainer: UIView!
    @IBOutlet private weak var initialsLabel: UILabel!
    
    private let url = URL(string: "https://picsum.photos/200/200")
    
    func load(contact: Contact) {
        self.name.text = contact.name
        if contact.id % 2 != 0 {
            avatar.kf.setImage(with: url)
            avatar.isHidden = false
            initialsContainer.isHidden = true
        } else {
            avatar.isHidden = true
            initialsContainer.isHidden = false
            initialsLabel.text = setInitials(for: contact.name)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func setInitials(for name: String) -> String {
        let names = name.split(separator: " ")
        var initals: String = ""
        names.forEach { name in
            initals.append(name.first?.uppercased() ?? "")
        }
        return initals
    }
}
