//
//  LoginModel.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/25/20.
//

import Foundation

struct LoginModel: Codable {
    var username: String
    var password: String
    var remember: String
    
    init(username: String, password: String, remember: String) {
        self.username = username
        self.password = password
        self.remember = remember
    }
}
