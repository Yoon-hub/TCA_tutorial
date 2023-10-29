//
//  ContatctsFeature.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/29.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
    let id = UUID()
    var name: String
}

struct ContactsFeature: Reducer {
    
    struct State: Equatable {
//        @PresentationState var addContact: AddContactFeature.State? // 부모와 자식 간의 상태 공유
//        @PresentationState var alert: AlertState<Action.Alert>? // chater3 수정
        @PresentationState var destination: Destination.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action: Equatable {
        case addButtonTapped
        //case addContact(PresentationAction<AddContactFeature.Action>) // 자식 기능에서 전송되는 모든 작업을 관찰
        case deleteButtonTapped(id: Contact.ID)
        //case alert(PresentationAction<Alert>)
        case destination(PresentationAction<Destination.Action>)
        
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                //state.addContact = AddContactFeature.State(contact: Contact(name: "")) // addContact 변수에 넣어주고
                state.destination = Destination.State.addContact(
                    AddContactFeature.State(contact: Contact(name: ""))
                )
                
                return .none
//            case .addContact(.presented(.delegate(.cancel))):
//                state.addContact = nil // nil 해서 지워주기
//                return .none
                
//            case let .addContact(.presented(.delegate(.saveContact(contact)))): // 추가하고 nil 해주기
////                guard let contact = state.addContact?.contact else {return .none}
//                state.contacts.append(contact)
//               // state.addContact = nil
//                return .none
//
//            case .addContact:
//                return .none
                
            case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
                state.contacts.append(contact)
                return .none
                
            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
              state.contacts.remove(id: id)
              return .none
                
            case .destination:
                return .none
                
                
//            case let .alert(.presented(.confirmDeletion(id: id))):
//                state.contacts.remove(id: id)
//                return .none
                
//            case .alert:
//                return .none
                
            case let .deleteButtonTapped(id: id):
                state.destination = .alert(
                  AlertState {
                    TextState("Are you sure?")
                  } actions: {
                    ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                      TextState("Delete")
                    }
                  }
                )
                return .none
            }
        }
//        .ifLet(\.$addContact, action: /Action.addContact) {
//            AddContactFeature()
//        }
//        .ifLet(\.$alert, action: /Action.alert)
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
     
        
    }
}

extension ContactsFeature {
    struct Destination: Reducer {
        enum State: Equatable {
            case addContact(AddContactFeature.State)
            case alert(AlertState<ContactsFeature.Action.Alert>)
        }
        
        enum Action: Equatable {
          case addContact(AddContactFeature.Action)
          case alert(ContactsFeature.Action.Alert)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.addContact, action: /Action.addContact) {
                AddContactFeature()
            }
        }
    }
}
    
