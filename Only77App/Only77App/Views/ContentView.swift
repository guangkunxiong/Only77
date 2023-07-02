//
//  ContentView.swift
//  Only77App
//
//  Created by yukun xie on 2023/6/16.
//

import SwiftUI


struct ContentView: View {
    //@Environment(\.presentationMode) var presentationMode
    
    @State var showSideMenu = false
    let mindarg : CGFloat = 100
    @State private var selectedTabIndex = 0
    @State private var offset: CGFloat = 0

    var body: some View {
        ZStack{
            VStack(spacing: 10) {
                HStack() {
                    Button(action: {
                        selectedTabIndex = 0
                    }) {
                        Text("情侣相册").foregroundColor(selectedTabIndex==0 ? .accent:.tint).bold()
                    }
                    
                    Button(action: {
                        selectedTabIndex = 1
                    }) {
                        Text("悄悄话").foregroundColor(selectedTabIndex==1 ? .accent:.tint).bold()
                    }
                    Button(action: {
                        selectedTabIndex = 2
                    }) {
                        Text("计划").foregroundColor(selectedTabIndex==2 ? .accent:.tint).bold()
                    }
                    Button(action: {
                        selectedTabIndex = 3
                    }) {
                        Text("纪念日").foregroundColor(selectedTabIndex==3 ? .accent:.tint).bold()
                    }
                }
                .frame(height:40).font(.title3).padding(.top,25)
                
                
                GeometryReader { geometry in
                    TabView(selection: $selectedTabIndex) {
                        CouplesAlbumView()
                            .tag(0)
                        
                        WhispersView()
                            .tag(1)
                        
                        PlanView()
                            .tag(2)
                        
                        MemorialDayView()
                            .tag(3)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .offset(x: -offset * geometry.size.width, y: 0)
                    .gesture(DragGesture()
                        .onChanged { value in
                            if value.translation.width > 0 && offset > 0 {
                                offset -= 1
                            } else if value.translation.width < 0 && offset < CGFloat(3) {
                                offset += 1
                            }
                        }
                    )
                }
                
            } .navigationBarHidden(true)
            
            SideMenuView()
                .offset(x: showSideMenu ? 0 : -270)
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            let shoulsShow = value.translation.width > self.mindarg
                            withAnimation {
                                showSideMenu = shoulsShow
                            }
                        })
                )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
