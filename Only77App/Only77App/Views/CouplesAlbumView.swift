//
//  CouplesAlbumView.swift
//  Only77App
//
//  Created by yukun xie on 2023/6/16.
//

import SwiftUI
import CircleMenu


struct CouplesAlbumView: View {
    
    let gridItems=Array(arrayLiteral: "77","Image1","Image2","Image3")
    
    
    @State public var showView2=false
    
    var body: some View {
        ZStack {
            VStack{
                ScrollView {
                    
                    if showView2{
                        CouplesAlubm2View(gridItems: gridItems)
                        
                    }else{
                        
                        ImgGridView(gridItems: gridItems)
                        
                        ImgGridView(gridItems: gridItems)
                    }
                    
                }
                Spacer()
                
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    SectorButtonLayout( showView2:$showView2)
                        .padding(30)
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
            // Color.black
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
                    .frame(width: 25).clipShape(Circle()).padding(.trailing, 10)
                
            }
            
            TextField("请输入文本", text: $text)
                .textFieldStyle(.plain).padding(.leading,10).font(.caption)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(gridItems, id: \.self) { item in
                    Image(item)
                        .resizable()
                        .scaledToFill()
                        .fullScreenCover(isPresented: $isPresented) {
                            FullScreenImageView(imgName: selectedImage, isPresented: $isPresented)
                        }
                    
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(width: 120,height: 120)
                        .cornerRadius(2)
                        .shadow(color: .gray, radius: 5, x: 0, y: 0)
                        .padding(2)
                        .onTapGesture {
                            selectedImage = item
                            isPresented.toggle()
                        }
                    
                }
            }
            .padding()
        }
        
    }
}

struct SectorButtonLayout: View {
    
    @Binding var showView2: Bool
    
    func handleButtonTap(title: Int) {
        switch(title){
        case 0:
            showView2 = !showView2
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("2")
            
        }
    }
    
    @State private var isExpanded = false
    
    let iconArray=Array(arrayLiteral: "viewfinder.circle.fill","plus.circle.fill","flag.checkered.circle.fill")
    
    
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
            ForEach(0..<iconArray.count, id: \.self) { i in
                Button(action: {
                    // 处理每个按钮的点击事件
                    handleButtonTap(title: i)
                    
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
        
        let angle = 0.8 * .pi / Double(iconArray.count) * Double(index)
        let x = cos(angle+110) * 90
        let y = sin(angle+110) * 90
        
        return CGSize(width: x, height: y)
    }
}


struct CouplesAlubm2View: View {
    
    let gridItems:Array<String>
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 0) {
            ForEach(gridItems, id: \.self) { item in
                GridItemView(item: item)
            }
        }
        //.padding()
    }
    
}

struct GridItemView:View{
    var item:String
    var body: some View{
        VStack(alignment: .leading){
            Image(item)
                .resizable()
                .scaledToFill()
            //.frame(maxWidth: .infinity)
                .frame(width: 190,height:240)
                .cornerRadius(2)
                .shadow(color: .gray, radius: 5, x: 0, y: 0)
            
            Text("这里是标题").padding(.leading,2)
            HStack{
                
                Image("77").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 25).clipShape(Circle()).padding(.leading, 2)
                
                Spacer()
                //
                //                Image(systemName: "camera")
                //                           .font(.system(size: 18))
                //                           .bold()
                //                           .foregroundColor(.accent)
                Text("2022/6/13").padding(.trailing, 10)
                
            }
        }.frame(width: 190,height:310).padding(5)
        
        
    }
}


struct CouplesAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        CouplesAlbumView()
    }
}
