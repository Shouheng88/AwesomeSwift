//
//  ProjectViewModel.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2023/3/22.
//

import Foundation

class ProjectViewModel: ObservableObject {

    static let STATE_LOAD_FINISHED = 0
    static let STATE_LOADING = 1
    
    @Published private(set) var projects: [Project] = []
    
    var state = ProjectViewModel.STATE_LOADING
    
    func request() {
        
    }
    
}
