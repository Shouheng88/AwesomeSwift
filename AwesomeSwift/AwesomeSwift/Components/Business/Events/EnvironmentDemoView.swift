//
//  EnvironmentDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/9.
//

import SwiftUI

struct EnvironmentDemoView: View {

    @StateObject private var score = MyScore()
    
    var body: some View {
        VStack {
            Button("Increase My Score", action: {
                score.score += 1
            }).frame(height: 40)
            ChildDemoView1()
            ChildDemoView2()
        }.environmentObject(score)
    }
}

struct ChildDemoView1: View {
    
    @EnvironmentObject var score: MyScore
    
    var body: some View {
        Text("My Score Is [1]: \(score.score)").frame(height: 40)
    }
}

struct ChildDemoView2: View {
    
    @EnvironmentObject var score: MyScore
    
    var body: some View {
        Text("My Score Is [2]: \(score.score)").frame(height: 40)
    }
}

class MyScore: ObservableObject {
    @Published var score: Int = 0
}

struct EnvironmentDemoView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentDemoView()
    }
}
