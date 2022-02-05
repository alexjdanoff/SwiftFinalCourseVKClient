//
//  Friend.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 23.11.2021.
//

import UIKit
import RealmSwift

class Friend: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String  = ""
    @objc dynamic var ownerID: String  = ""
    
    init(name:String, avatar:String, ownerID:String) {
        self.name = name
        self.avatar = avatar
        self.ownerID = ownerID
    }
    
    required override init() {
        super.init()
    }
}
