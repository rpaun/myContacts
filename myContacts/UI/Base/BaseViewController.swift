//
//  BaseViewController.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import UIKit
import Combine

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    var viewModel = T.init()
    
    var bag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
