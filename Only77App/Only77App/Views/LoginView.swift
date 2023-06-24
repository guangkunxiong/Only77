//
//  Login.swift
//  Only77App
//
//  Created by yukun xie on 2023/6/18.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggingIn: Bool = false
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.text
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10)
                
                NavigationLink(destination: ContentView()) {
                    Text("导航")
                        .foregroundColor(.blue)
                }
                
                VStack {
                    Image("77")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 160, height: 160)
                        .padding(.top, 50)
                    
                    TextField("用户名", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .padding(.bottom, 20)
                        .padding(.top, 50)
                    
                    SecureField("密码", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        self.login()
                    }) {
                        Text("登录")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(isLoggingIn ? Color.gray : Color.accent)
                            .cornerRadius(25)
                    }
                    .disabled(isLoggingIn)
                    .opacity(isLoggingIn ? 0.5 : 1.0)
                    .padding(.top, 50)
                    
               // isActive: $isLoggedIn,
                    
                    NavigationLink(destination: ContentView(),isActive: $isLoggedIn, label: {
                        
                    })
                    
                    Spacer()
                }
                .padding()
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func login() {
        isLoggingIn = true
        APIManager.shared.login(username: username, password: password) { (result) in
            self.isLoggingIn = false
            
            switch result {
            case .success(let user):
                print("登录成功")
                self.isLoggedIn = true
            case .failure(let error):
                print("登录失败: \(error)")
            }
        }
        
        isLoggedIn=true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
