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
        @PresentationState var addContact: AddContactFeature.State? // 부모와 자식 간의 상태 공유
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action: Equatable {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>) // 자식 기능에서 전송되는 모든 작업을 관찰
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(contact: Contact(name: "")) // addContact 변수에 넣어주고
                return .none
//            case .addContact(.presented(.delegate(.cancel))):
//                state.addContact = nil // nil 해서 지워주기
//                return .none
            case let .addContact(.presented(.delegate(.saveContact(contact)))): // 추가하고 nil 해주기
//                guard let contact = state.addContact?.contact else {return .none}
                state.contacts.append(contact)
               // state.addContact = nil
                return .none
            case .addContact:
                return .none
            }
        }
        .ifLet(\.$addContact, action: /Action.addContact) {
            AddContactFeature()
        }
    }
    
}
