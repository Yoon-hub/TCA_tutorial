//
//  Screen.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/30.
//

import Foundation
import ComposableArchitecture
import TCACoordinators

struct Screen: Reducer {
    enum State: Equatable {
        case contacts(ContactsFeature.State)
        case addContact(AddContactFeature.State)
        case contactDetail(ContactDetailFeature.State)
    }
    
    enum Action: Equatable {
        case contacts(ContactsFeature.Action)
        case addContact(AddContactFeature.Action)
        case contactDetail(ContactDetailFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: /State.contacts, action: /Action.contacts) {
            ContactsFeature()
        }
        
        Scope(state: /State.addContact, action: /Action.addContact) {
            AddContactFeature()
        }
        
        Scope(state: /State.contactDetail, action: /Action.contactDetail) {
            ContactDetailFeature()
        }
        
    }
}
