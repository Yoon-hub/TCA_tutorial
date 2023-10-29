//
//  ContactDetailFeature.swift
//  TCA_tutorial
//
//  Created by 최윤제 on 2023/10/29.
//

import ComposableArchitecture

struct ContactDetailFeature: Reducer {
    
    struct State: Equatable {
        let contact: Contact
    }
    
    enum Action: Equatable {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
            
        }
    }
    
}
