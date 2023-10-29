//
//  AddContactView.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/29.
//

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
  let store: StoreOf<AddContactFeature>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      Form {
          TextField("name", text: viewStore.binding(get: \.contact.name, send: { value in
              AddContactFeature.Action.setName(value)
          }))
        Button("Save") {
          viewStore.send(.saveButtonTapped)
        }
      }
      .toolbar {
        ToolbarItem {
          Button("Cancel") {
            viewStore.send(.cancelButtonTapped)
          }
        }
      }
      .onAppear() {
          viewStore.send(.appear)
      }
    }

  }
}

struct AddContactPreviews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      AddContactView(
        store: Store(
          initialState: AddContactFeature.State(
            contact: Contact(name: "Blob")
          )
        ) {
          AddContactFeature()
        }
      )
    }
  }
}
