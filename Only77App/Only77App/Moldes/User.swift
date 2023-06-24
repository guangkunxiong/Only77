//
//  User.swift
//  Only77App
//
//  Created by yukun xie on 2023/6/24.
//

import Foundation

//user model
struct User: Codable {
    
    let id: String
    let password:String
    let email: String
    let username: String
    let image: String?
    
}

