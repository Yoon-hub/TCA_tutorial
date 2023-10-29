//
//  ContactsView.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/29.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    let store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                List {
                    ForEach(viewStore.state.contacts) { contact in
                        Text(contact.name)
                    }
                }
                .navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .sheet(store: self.store.scope(state: \.$addContact, action: {.addContact($0)})) { store in
            NavigationStack {
                AddContactView(store: store)
            }
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
  static var previews: some View {
    ContactsView(
      store: Store(
        initialState: ContactsFeature.State(
          contacts: [
            Contact(name: "Blob"),
            Contact(name: "Blob Jr"),
            Contact(name: "Blob Sr"),
          ]
        )
      ) {
        ContactsFeature()
      }
    )
  }
}
