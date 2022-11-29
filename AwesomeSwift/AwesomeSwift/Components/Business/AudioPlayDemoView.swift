//
//  AudioPlayDemo.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/29.
//

import SwiftUI
import AVFoundation

var soundPlayer: AVAudioPlayer?

func playAudio(forResource: String, ofType: String) {
    let path = Bundle.main.path(forResource: forResource, ofType: ofType)!
    let url = URL(fileURLWithPath: path)
    do {
        soundPlayer = try AVAudioPlayer(contentsOf: url)
        soundPlayer?.play()
    } catch {
        print("音频文件出现问题")
    }
}

struct AudioPlayDemoView: View {
    
    @State private var tip: String = ""
    
    var body: some View {
        VStack {
            Text(tip).foregroundColor(.gray).font(.system(size: 12))
            Button("Play", action: {
                playAudio(forResource: "y1309", ofType: "mp3")
            }).frame(height: 40)
            Button("Stop", action: {
                soundPlayer?.stop()
            }).frame(height: 40)
        }.navigationTitle("Audio Play Demo")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AudioPlayDemo_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayDemoView()
    }
}
