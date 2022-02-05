//
//  Group.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 23.11.2021.
//

import UIKit
import RealmSwift

class Group: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String?  = ""
    @objc dynamic var id: Int = 0
    
    init(name: String, avatar: String, id: Int) {
        self.name = name
        self.avatar = avatar
        self.id = id
    }
    
    required override init() {
        super.init()
    }
    
}
