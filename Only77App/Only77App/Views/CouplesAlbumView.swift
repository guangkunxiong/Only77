//
//  CouplesAlbumView.swift
//  Only77App
//
//  Created by yukun xie on 2023/6/16.
//

import SwiftUI


struct CouplesAlbumView: View {
    
    let gridItems=Array(arrayLiteral: "77","Image1","Image2","Image3")
    
    var body: some View {
        ZStack {
            VStack{
                ScrollView {
                    
                    ImgGridView(gridItems: gridItems)
                    
                    ImgGridView(gridItems: gridItems)
                    
                }
                
                Spacer()
                
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    SectorButtonLayout( radius: 90, buttonSize: 50, centerButtonSize: 60)
                        .padding()
                }
            }
        }
        
    }
}

struct FullScreenImageView: View {
    var imgName:String
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black
            Image(imgName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented.toggle()
                }
        }
    }
}

struct ImgGridView:View{
    
    let gridItems:Array<String>
    
    @State private var text: String = ""
    
    @State private var isPresented = false
    
    @State private var selectedImage:String=""

    var body: some View{
        
    VStack{
        HStack{
            Image(systemName: "camera")
                       .font(.system(size: 20))
                       .bold()
                       .foregroundColor(.accent).padding(.leading, 10)
            Text("2022/6/15").bold()
            Spacer()
            Image("77").resizable().aspectRatio(contentMode: .fit)
.frame(width: 20).clipShape(Circle()).padding(.trailing, 10)
                    
        }
        
        TextField("请输入文本", text: $text)
            .textFieldStyle(.plain).padding(.leading,10).font(.caption)
        
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(gridItems, id: \.self) { item in
               Image(item)
                    .resizable()
                    .scaledToFill()
                    .onTapGesture {
                        selectedImage = item
                        isPresented.toggle()
                    }
                    .fullScreenCover(isPresented: $isPresented) {
                        FullScreenImageView(imgName: selectedImage, isPresented: $isPresented)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(width: 120,height: 120)
                    .cornerRadius(2)
                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
                    .padding(2)
                
            }
        }
        .padding()
    }
       
    }
}

struct SectorButtonLayout: View {
    let radius: CGFloat // 圆的半径
    let buttonSize: CGFloat // 按钮的尺寸
    let centerButtonSize: CGFloat // 圆心按钮的尺寸
    
    @State private var isShow=false
    
    var body: some View {
        ZStack {
            ForEach(0..<3) { index in
                let angle = 96.0 / CGFloat(3 - 1) * CGFloat(index) + 179.0
                let radians = angle * .pi / 180.0
                let x = radius * cos(radians)
                let y = radius * sin(radians)
                
                if isShow{
                    Button(action: {
                        
                    }) {
                        Circle()
                            .fill(Color.clear)
                            .frame(width: buttonSize, height: buttonSize)
                            .overlay(
                                Image(systemName: "plus.circle.fill")
                                             .resizable()
                                             .frame(width: 45, height: 45)
                                              .foregroundColor(.accent)
                            )
                            .position(x: x + radius, y: y + radius)
                    }
                }
            }
            
            Button(action: {
                isShow = !isShow
            }) {
                Circle()
                    .fill(.clear)
                    .frame(width: centerButtonSize, height: centerButtonSize)
                    .overlay(
                        Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.accent)
                    )
                    .position(x: radius, y: radius)
            }
        }.frame(maxWidth: 130, maxHeight: 110) // 设置最大宽度和最大高度
.animation(.easeIn, value: isShow)
    
    }
}




struct CouplesAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        CouplesAlbumView()
    }
}
