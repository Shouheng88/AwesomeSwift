//
//  TaskDataStore.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/28.
//

import Foundation
import SQLite

// https://github.com/stephencelis/SQLite.swift
// 文档：https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#sqliteswift-documentation
// 需要考虑升级的情况，比如增加列和删除列等，所以，考虑是否需要在数据库的文件名中增加信息来判断 db 的版本
class TaskDataStore {

    static let DIR_TASK_DB = "TaskDB"
    static let STORE_NAME = "task.sqlite3"

    private let tasks = Table("tasks")

    private let id = Expression<Int64>("id")
    private let taskName = Expression<String>("taskName")
    private let date = Expression<Date>("date")
    private let status = Expression<Bool>("status")

    static let shared = TaskDataStore()

    private var db: Connection? = nil

    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dirPath = docDir.appendingPathComponent(Self.DIR_TASK_DB)

            do {
                // Documents/TaskDB/task.sqlite3
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
                db = try Connection(dbPath)
                createTable()
                print("SQLiteDataStore init successfully at: \(dbPath) ")
            } catch {
                db = nil
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }

    private func createTable() {
        guard let database = db else {
            return
        }
        do {
            try database.run(tasks.create { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(taskName)
                table.column(date)
                table.column(status)
            })
            print("Table Created...")
        } catch {
            print(error)
        }
    }
    
    func insert(task: TaskModel) -> TaskModel {
        guard let database = db else {
            task.message = "db is nil"
            return task
        }
        do {
            let insert = tasks.insert(taskName <- task.name, date <- task.date, status <- task.status)
            let rowid = try database.run(insert)
            task.id = Int(rowid)
            // INSERT INTO "tasks" ("taskName", "date") VALUES ('task', Date())
        } catch {
            task.message = "\(error)"
        }
        return task
    }
    
    func getAll() -> [TaskModel] {
        guard let database = db else {
            print("db is nil")
            return []
        }
        var models: [TaskModel] = []
        do {
            for task in try database.prepare(tasks) {
                print("id: \(task[id]), taskName: \(task[taskName]), date: \(task[date]), status: \(task[status])")
                // id: 1, name: Optional("Alice"), email: alice@mac.com
                models.append(TaskModel(id: Int(task[id]), name: task[taskName], date: task[date], status: task[status]))
            }
            // SELECT * FROM "tasks"
        } catch {
            print(error)
        }
        return models
    }
}

class TaskModel: NSObject {
    var id: Int?
    var name: String
    var date: Date
    var status :Bool
    var message: String = ""
    
    init(id: Int?, name: String, date: Date, status: Bool) {
        self.id = id
        self.name = name
        self.date = date
        self.status = status
    }
    
    override var description: String {
        return "Task { name: \(name), date: \(date), status: \(status)}"
    }
}

