//
//  AddContactFeature.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/29.
//

import ComposableArchitecture

struct AddContactFeature: Reducer {
  struct State: Equatable {
    var contact: Contact
  }
  enum Action: Equatable {
    case cancelButtonTapped
    case saveButtonTapped
    case setName(String)
    case delegate(Delegate)
      
      enum Delegate: Equatable {
         // case cancel
          case saveContact(Contact)
      }
  }
    @Dependency(\.dismiss) var dismiss
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .cancelButtonTapped:
        return .run { _ in
            await self.dismiss()
        }

    case .delegate:
        return .none
        
    case .saveButtonTapped:
        return .run { [contact = state.contact] send in
          await send(.delegate(.saveContact(contact)))
          await self.dismiss()
        }

    case let .setName(name):
      state.contact.name = name
      return .none
    }
  }
}
