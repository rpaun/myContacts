//
//  BaseViewModel.swift
//  myContacts
//
//  Created by Radu Paun on 31.07.2022.
//

import Foundation
import Combine

enum ViewModelState {
    case loading
    case idle
}

class BaseViewModel: ObservableObject {
    
    var state = PassthroughSubject<ViewModelState, Never>()
    var bag = Set<AnyCancellable>()
    
    required init() {
        print("VM Init")
    }
}
