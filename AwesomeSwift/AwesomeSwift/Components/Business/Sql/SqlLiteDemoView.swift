//
//  SqlLiteDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/28.
//

import SwiftUI

struct SqlLiteDemoView: View {
    
    @State private var result: String = ""
    
    var body: some View {
        VStack {
            Text(result).foregroundColor(.gray).font(.system(size: 12))
            Button("Insert One Record", action: {
                let task = TaskDataStore.shared.insert(task: TaskModel(id: nil, name: "task", date: Date(), status: true))
                self.result = "inserted: \(String(describing: task.id)), \(task.message)"
            }).frame(height: 40)
            Button("Get All Records", action: {
                let tasks = TaskDataStore.shared.getAll()
                if tasks.isEmpty {
                    self.result = "empty -.-"
                } else {
                    self.result = "- " + "\n- ".join(list: tasks)
                }
            }).frame(height: 40)
        }.navigationTitle("SQLite Demo")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SqlLiteDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SqlLiteDemoView()
    }
}
