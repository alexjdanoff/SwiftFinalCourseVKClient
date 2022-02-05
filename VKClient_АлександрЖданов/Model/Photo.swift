//
//  Photo.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 06.01.2022.
//

import UIKit
import RealmSwift

class Photo: Object {
    @objc dynamic var photo: String = ""
    @objc dynamic var ownerID: String  = ""
    
    init(photo: String, ownerID: String) {
        self.photo = photo
        self.ownerID = ownerID
    }
    
    required override init() {
        super.init()
    }
}
