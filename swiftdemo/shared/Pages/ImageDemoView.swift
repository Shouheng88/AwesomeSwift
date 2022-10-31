//
//  ImageDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/14.
//

import SwiftUI

struct ImageDemoView: View {
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    VStack {
                        Text("图片资源")
                        HStack {
                            Image("sample_image")
                                .onTapGesture {
                                    print("Hello 1x")
                                }
                            Image("sample_image")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .bottom)
                                .onTapGesture {
                                    print("Hello 30x")
                                }
                            Image("sample_image")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .bottom)
                                .onTapGesture {
                                    print("Hello 50x")
                                }.blur(radius: 3)
                        }
                    }
                }
                HStack {
                    Image("sample_image")
                        .onTapGesture {
                            print("Hello 1x")
                        }
                    Image("sample_image")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .bottom)
                        .onTapGesture {
                            print("Hello 30x")
                        }
                    Image("sample_image")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .bottom)
                        .onTapGesture {
                            print("Hello 50x")
                        }.blur(radius: 3)
                }
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        Image("postimage")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.blue, lineWidth: 5)
                                    .shadow(color: .gray, radius: 2, x: 2, y: 2)
                            )
                        Image("postimage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.blue, lineWidth: 2)
                                    .shadow(color: .gray, radius: 2, x: 2, y: 2)
                            )
                        Image("postimage")
                            .resizable()
                            .scaleEffect()
                            .frame(width: 100, height: 100)
//                            .overlay(ShapeStyle())
                        Image("postimage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .top)
                        Image("postimage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                        Image("postimage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .bottom)
                        Image("postimage")
                            .resizable()
                            .clipShape(ContainerRelativeShape())
                            .frame(width: 100, height: 100)
                        Image("postimage")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                        Image("postimage")
                            .resizable()
                            .clipShape(Ellipse())
                            .frame(width: 100, height: 100)
                        Image("postimage")
                            .resizable()
                            .clipShape(Capsule())
                            .frame(width: 100, height: 100)
                    }
                }
                HStack {
                    Image(systemName: "3.circle").imageScale(.large)
                    Image(systemName: "13.circle").imageScale(.large)
                    Image(systemName: "50.circle").imageScale(.large) // max
                }
                MyImageView().clipShape(Capsule())
                MyImageView()
            }
        }.navigationTitle(Text("标题啊"))
            .navigationBarHidden(false)
            .navigationViewStyle(.columns)
            .navigationBarItems(leading: Text("Leading"), trailing: Text("Trialing")
                .onTapGesture { print("呦呵") })
    }
}

struct ImageDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDemoView()
    }
}
