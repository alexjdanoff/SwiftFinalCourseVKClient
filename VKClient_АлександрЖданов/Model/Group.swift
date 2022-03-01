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

struct GroupsResponse:  Decodable {
    var response: Response
    
    struct Response: Decodable {
        var count: Int
        var items: [Item]
        
        struct Item: Decodable {
            var name: String
            var logo: String
            var id: Int
            
            enum CodingKeys: String, CodingKey {
                case name
                case logo = "photo_50"
                case id
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                name = try container.decode(String.self, forKey: .name)
                logo = try container.decode(String.self, forKey: .logo)
                id = try container.decode(Int.self, forKey: .id)
            }
        }
    }
}
