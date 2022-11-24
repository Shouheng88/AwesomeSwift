//
//  ContentView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/10/31.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var text = ""
    @State private var bold = false
    @State private var italic = false
    @State private var fontSize = 12.0
    
    private var appComponentsDemo: some View {
        Section(content: {
            VStack {
                NavigationLink{
                    ProjectList()
                } label: {
                    Text("WanAndroid")
                }.frame(height: 40)
                
                NavigationLink(destination: {
                    ThemeDemoView()
                }, label: {
                    Text("Themes")
                }).frame(height: 40)
                            
                NavigationLink(destination: {
                    PermissionDemoView()
                }, label: {
                    Text("Permission Demo")
                }).frame(height: 40)
                
                NavigationLink(destination: {
                    LaunchPhonePageDemo()
                }, label: {
                    Text("Launch Phone Pages Demo")
                }).frame(height: 40)
                
                NavigationLink(destination: {
                    EmailDemoView()
                }, label: {
                    Text("Email Demo")
                }).frame(height: 40)
                
                NavigationLink(destination: {
                    ShareDemoView()
                }, label: {
                    Text("Share Demo")
                }).frame(height: 40)
            }
        }, header: {
            Text("App Components Demo")
        })
    }
    
    private var uiStructureComponentsDemo_Part1: some View {
        VStack {
            NavigationLink(destination: {
                TabPageDemoView()
            }, label: {
                Text("Tab Picker Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                TabDemoView()
            }, label: {
                Text("Tab Page Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                ImmersiveView()
            }, label: {
                Text("Immersive Page Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                KeyboardDemoView()
            }, label: {
                Text("Keyboard Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                ListSampleView()
            }, label: {
                Text("List Demo")
            }).frame(height: 40)
         
            NavigationLink(destination: {
                WhatsNewKitView()
            }, label: {
                Text("WhatsNewKit Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                NotificationBannerView()
            }, label: {
                Text(R.string.localizable.banner_test_entry())
            }).frame(height: 40)
            
            NavigationLink(destination: {
                SegmentedViewDemo()
            }, label: {
                Text("JXSegmentedView Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                PullToRefreshViewDemo()
            }, label: {
                Text("Pull To Refresh View Demo")
            }).frame(height: 40)
        }
    }
    
    private var uiStructureComponentsDemo_Part2: some View {
        VStack {
            
        }
    }
    
    private var uiStructureComponentsDemo: some View {
        Section(content: {
            VStack {
                uiStructureComponentsDemo_Part1
                uiStructureComponentsDemo_Part2
            }
        }, header: {
            Text("UI Structure Components Demo")
        })
    }
    
    private var dataCompontntsDemo: some View {
        Section(content: {
            NavigationLink(destination: {
                StorageDemoView()
            }, label: {
                Text("Storage Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                EnvironmentDemoView()
            }, label: {
                Text("Environment Object Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                AppInfoDemoView()
            }, label: {
                Text("App Info Demo")
            }).frame(height: 40)
        }, header: {
            Text("Data Compontents Demo")
        })
    }
    
    private var widgetComponentsDemo: some View {
        Section(content: {
            NavigationLink(destination: {
                TextDemoView()
            }, label: {
                Text("SwiftUI Text Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                ButtonDemoView()
            }, label: {
                Text("SwiftUI Button Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                TextFieldDemoView()
            }, label: {
                Text("SwiftUI TextField Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                ImageDemoView()
            }, label: {
                Text("SwiftUI Image Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                FormDemoView()
            }, label: {
                Text("SwiftUI Form Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                AnimationDemoView()
            }, label: {
                Text("SwiftUI Animation Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                LayoutDemoView()
            }, label: {
                Text("SwiftUI Layout Demo")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                PopupDemoView()
            }, label: {
                Text("SwiftUI Popup Demo")
            }).frame(height: 40)
        }, header: {
            Text("SwiftUI Widget Components Demo")
        })
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    appComponentsDemo
                    dataCompontntsDemo
                    uiStructureComponentsDemo
                    widgetComponentsDemo
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width)
            }.toolbar {
                // 工具栏的使用方法，但是需要放到 NavigationView 内部
                ToolbarItemGroup {
                     Slider(
                         value: $fontSize,
                         in: 8...120,
                         minimumValueLabel:
                             Text("A").font(.system(size: 8)),
                         maximumValueLabel:
                             Text("A").font(.system(size: 16))
                     ) {
                         Text("Font Size 15")
                     }
                     .frame(width: 150)
                     Toggle(isOn: $bold) {
                         Image(systemName: "bold")
                     }
                     Toggle(isOn: $italic) {
                         Image(systemName: "italic")
                     }
                }
            }.navigationTitle(Text("Aswsome Swift"))
                .onReceive(NotificationCenter.Publisher(
                    center: NotificationCenter.default,
                    name: NSNotification.Name(Events.SMAPLE_NOTIFICATION_NAME)
                ), perform: { out in
                    debugPrint("RECEIVED NOTIFICATION WITH \(String(describing: out.object))")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
