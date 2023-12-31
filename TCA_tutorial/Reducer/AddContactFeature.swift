//
//  AddContactFeature.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/29.
//

import ComposableArchitecture
import TCACoordinators

struct AddContactFeature: Reducer {
  struct State: Equatable {
    var contact: Contact
  }
  enum Action: Equatable {
    case cancelButtonTapped
    case saveButtonTapped
    case setName(String)
    case delegate(Delegate)
    case addWhenViewAppeat(Contact)
    case appear
      
      enum Delegate: Equatable {
         // case cancel
          case saveContact(Contact)
      }
  }
   
    @Dependency(\.uuid) var uuid
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
    case .appear:
        
        return .send(.addWhenViewAppeat(Contact(name: "윤제")))

    case let .setName(name):
      state.contact.name = name
      return .none
    default:
        return .none
    }
  }
}
