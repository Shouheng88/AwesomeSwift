//
//  ImageDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/14.
//

import Rswift
import SwiftUI

struct ImageDemoView: View {

    @State private var tip: String = ""
    @State private var playLottie: Int = 0

    var resouceImageView: some View {
        Section(content: {
            VStack {
                Text("[\(self.tip)]")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                HStack {
                    Image(uiImage: R.image.heart_lock()!)
                        .onTapGesture {
                            self.tip = "Clicked image"
                        }
                    Image(uiImage: R.image.heart_lock()!)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            self.tip = "Clicked 30x image"
                        }
                    Image(uiImage: R.image.heart_lock()!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            self.tip = "Clicked 50x image"
                        }.blur(radius: 3)
                }
            }
        }, header: {
            Text("Assets Image")
        })
    }
    
    var gradientSampleView: some View {
        Section(content: {
            VStack(spacing: 10) {
                LinearGradient(
                    colors: [.red, .green, .blue],
                    startPoint: .top,
                    endPoint: .bottom
                ).frame(width: 200, height: 100)
                    .overlay(Text("LinearGradient").foregroundColor(.white))
                
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(.blue)
                    .frame(width: 200, height: 100)
                    .overlay(Text("RoundedRectangle").foregroundColor(.white))
                
                Capsule().fill(.red)
                    .frame(width: 200, height: 100)
                    .overlay(Text("Capsule").foregroundColor(.white))
                
                Circle().fill(.green)
                    .frame(width: 200, height: 100)
                    .overlay(Text("Capsule").foregroundColor(.white))
            }
        }, header: {
            Text("Shape Sample View")
        })
    }
    
    var bigImageSampleView: some View {
        Section(content: {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.blue, lineWidth: 5)
                                .shadow(color: .gray, radius: 2, x: 2, y: 2)
                        )
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.blue, lineWidth: 2)
                                .shadow(color: .gray, radius: 2, x: 2, y: 2)
                        )
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .scaleEffect()
                        .frame(width: 100, height: 100)
                }
                HStack {
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .top)
                        .overlay(Text("Top alignment"))
//                        .overlay(content: { // This method is only available on 16.0 and newer
//                            Text("Top alignment")
//                        })
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        .overlay(Text("Center alignment"))
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .bottom)
                        .overlay(Text("Bottom alignment"))
                }
                HStack {
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .clipShape(ContainerRelativeShape())
                        .frame(width: 100, height: 100)
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                    Image(uiImage: R.image.the_soup()!)
                        .resizable()
                        .clipShape(Ellipse())
                        .frame(width: 100, height: 100)
                }
                HStack {
                    Image(uiImage: R.image.the_soup()!)
                         .resizable()
                         .clipShape(Capsule())
                         .frame(width: 100, height: 100)
                }
            }
        }, header: {
            Text("Big Image Sample")
        })
    }
    
    var resourceSampleView: some View {
        HStack {
            Image(systemName: "3.circle").imageScale(.large)
            Image(systemName: "13.circle").imageScale(.large)
            Image(systemName: "50.circle").imageScale(.large) // max
        }
    }
    
    var lottieSampleView: some View {
        VStack {
            LottieView(lottieFile: "thank_you", play: self.$playLottie)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    self.playLottie = self.playLottie + 1
                }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                resouceImageView
                gradientSampleView
                bigImageSampleView
                resourceSampleView
                lottieSampleView
            }
        }.navigationTitle(Text("The Title"))
            .navigationBarHidden(false)
            .navigationBarItems(
                leading: Text("Leading"),
                trailing: Text("Trialing").onTapGesture {
                    self.tip = "on trialing clicked"
                }
            )
    }
}

struct ImageDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDemoView()
    }
}
