//
//  Session.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 26.12.2021.
//

import Foundation
import SwiftKeychainWrapper

class Session {
    private init() {}
    static let instance = Session()

    var token: String {
        get{ KeychainWrapper.standard.string(forKey: "tokenVK") ?? "" }
        set{ KeychainWrapper.standard.set(newValue, forKey: "tokenVK") }
    }
    
    var userId: Int {
        get { KeychainWrapper.standard.integer(forKey: "userId") ?? 0 }
        set { KeychainWrapper.standard.set(newValue, forKey: "userId") }
    }
        
    var expiredDate: Date {
        get {
            UserDefaults.standard.register(defaults: ["expiresIn" : Date()])
            return UserDefaults.standard.object(forKey: "expiresIn") as! Date
        }
        set { UserDefaults.standard.set(newValue, forKey: "expiresIn") }
    }
}
