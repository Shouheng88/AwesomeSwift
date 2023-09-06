//
//  SqlLiteDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/28.
//

import SwiftUI

/// SQL 示例
struct SqlLiteDemoView: View {
    
    @State private var result: String = ""
    
    var body: some View {
        VStack {
            Text(result).foregroundColor(.gray).font(.system(size: 12))
            Button("插入一条记录", action: {
                let task = TaskDataStore.shared.insert(task: TaskModel(id: nil, name: "task", date: Date(), status: true))
                self.result = "inserted: \(String(describing: task.id)), \(task.message)"
            }).frame(height: 40)
            Button("获取所有记录", action: {
                let tasks = TaskDataStore.shared.getAll()
                if tasks.isEmpty {
                    self.result = "记录为空 -.-"
                } else {
                    self.result = "全部记录如下：\n- " + "\n- ".join(list: tasks)
                }
            }).frame(height: 40)
        }.navigationTitle("SQLite 操作示例")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SqlLiteDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SqlLiteDemoView()
    }
}
