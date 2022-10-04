//
//  ContentView.swift
//  Shared
//
//  Created by 王守恒 on 2022/9/10.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @EnvironmentObject var store: SharedStore
    
    // 这里的注解什么含义？？
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        // NavigationView 是什么？？
        NavigationView {
            List {
                Group {
                    NavigationLink {
                        AnimationDemoView()
                    } label: {
                        Text("Animation demo")
                    }
                }
                Group {
                    NavigationLink {
                        TextDemoView()
                    } label: {
                        Text("文本控件示例")
                    }
                    NavigationLink {
                        TextFieldDemoView()
                    } label: {
                        Text("输入框示例")
                    }
                    NavigationLink {
                        ImageDemoView()
                    } label: {
                        Text("图片控件")
                    }
                    NavigationLink {
                        ButtonDemoView()
                    } label: {
                        Text("按钮控件")
                    }
                    NavigationLink {
                        TabDemoView()
                    } label: {
                        Text("TAB 示例")
                    }
                }
                NavigationLink {
                    SectionDemoView(viewModel: SectionDemoViewModel())
                } label: {
                    Text("Section 示例")
                }
                NavigationLink {
                    StackDemoView()
                } label: {
                    Text("Stack 示例")
                }
                NavigationLink {
                    AlertDemoView()
                } label: {
                    Text("各种对话框和提示")
                }
                NavigationLink {
                    WebDemoView()
                } label: {
                    Text("网页加载")
                }
                NavigationLink {
                    TabPageDemoView()
                } label: {
                    Text("Tab styled page")
                }
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }//.opacity(0.2).shadow(color: .black, radius: 1, x: 1, y: 1)
            Text("Select an item")
        }
    }

    // 这类 ACtion 函数对声明有什么要求？比如参数？
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // 这里的 error 从哪里来？？
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// 这个声明是什么含义？用来做什么？？
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// 还有这个？？？
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
