//
//  ContentView.swift
//  Only77App
//
//  Created by yukun xie on 2023/6/16.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedTabIndex = 0
    var body: some View {
        
        VStack(spacing: 10) {
                 HStack() {
                     Button(action: {
                         selectedTabIndex = 0
                     }) {
                         Text("情侣相册")
                     }
            
                     Button(action: {
                         selectedTabIndex = 1
                     }) {
                         Text("悄悄话")
                     }
                     Button(action: {
                         selectedTabIndex = 2
                     }) {
                         Text("计划")
                     }
                     Button(action: {
                         selectedTabIndex = 3
                     }) {
                         Text("纪念日")
                     }
                 }
                 .frame(height: 40)
                 
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
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
             }
        
     
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
