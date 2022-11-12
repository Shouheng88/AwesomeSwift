//
//  DeleteListView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/12.
//

import SwiftUI

struct OptionListView: View {
    
    @State var messages: [Message] = (0...60).map { Message(text: "message:\($0)") }
    
    var body: some View {
        List {
            ForEach(messages) { message in
                Text(message.text)
            }
            .onDelete(perform: deleteRow)
            .onMove{ from,to in
                if from.first! != to {
                    self.messages.move(fromOffsets: from, toOffset: to)
                }
            }
        }.navigationTitle("Option List Sample")
    }
    
    func deleteRow(at offsets: IndexSet) {
        messages.remove(atOffsets: offsets)
    }
}

struct DeleteListView_Previews: PreviewProvider {
    static var previews: some View {
        OptionListView()
    }
}
