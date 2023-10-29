//
//  ContactDetailView.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/29.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    
    let store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0} ) { viewStore in
            Form {
                
            }
            .navigationBarTitle(Text(viewStore.contact.name))
        }
    }
    
}

struct ContactDetailPreviews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ContactDetailView(
        store: Store(
          initialState: ContactDetailFeature.State(
            contact: Contact(name: "Blob")
          )
        ) {
          ContactDetailFeature()
        }
      )
    }
  }
}
