//
//  PopupButton.swift
//  Only77App
//
//  Created by yukun xie on 2023/6/22.
//

import SwiftUI

struct PopupButton: View {
    // 是否展开按钮
       @State private var isExpanded = false
        let iconArray=Array(arrayLiteral: "viewfinder.circle.fill","plus.circle.fill","flag.checkered.circle.fill")
       // 按钮的数量
       let count = 3
       
       var body: some View {
           ZStack {
               // 主按钮
               Button(action: {
                   withAnimation {
                       self.isExpanded.toggle()
                   }
               }) {
                   Image(systemName: "pencil.circle.fill")
                       .resizable()
                       .frame(width: 50, height: 50)
                       .foregroundColor(.accent)
               }
               
               // 环形按钮
               ForEach(0..<count, id: \.self) { i in
                   Button(action: {
                       // 处理每个按钮的点击事件
                   }) {
                       Image(systemName:iconArray[i])
                           .resizable()
                           .frame(width: 50, height: 50)
                           .foregroundColor(.accent)
                   }
                   .offset(self.getOffset(for: i))
                   .opacity(self.isExpanded ? 1 : 0)
               }
           }
       }
       
       // 计算每个按钮的位置
       private func getOffset(for index: Int) -> CGSize {
           guard isExpanded else {
               return .zero
           }
           
           let angle = 0.8 * .pi / Double(count) * Double(index)
           let x = cos(angle+110) * 90
           let y = sin(angle+110) * 90
           
           return CGSize(width: x, height: y)
       }
}



struct PopupButton_Previews: PreviewProvider {
    static var previews: some View {
        PopupButton()
    }
}
