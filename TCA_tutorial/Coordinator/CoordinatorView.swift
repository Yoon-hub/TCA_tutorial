//
//  CoordinatorView.swift
//  TCA_tutorial
//
//  Created by VP on 2023/10/30.
//

import ComposableArchitecture
import TCACoordinators
import SwiftUI

struct CoordinatorView: View {
    let store: StoreOf<Coordinator>
    
    public init(store: StoreOf<Coordinator>) {
        self.store = store
    }
    
    var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) { screen in
                switch screen {
                case .addContact:
                    CaseLet(/Screen.State.addContact, action: Screen.Action.addContact, then: AddContactView.init)
                case .contacts:
                    CaseLet(/Screen.State.contacts, action: Screen.Action.contacts, then: ContactsView.init)
                case .contactDetail:
                    CaseLet(/Screen.State.contactDetail, action: Screen.Action.contactDetail, then: ContactDetailView.init)
                }
            }
        }
    }
}
