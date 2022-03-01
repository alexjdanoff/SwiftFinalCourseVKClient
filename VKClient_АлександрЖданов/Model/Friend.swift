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

struct FriendsResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var count: Int
        var items: [Item]
        
        struct Item: Decodable {
            var id: Int
            var firstName: String
            var lastName: String
            var avatar: String
            var deactivated: String?
            
            private enum CodingKeys: String, CodingKey {
                case id
                case firstName = "first_name"
                case lastName = "last_name"
                case avatar  = "photo_50"
                case deactivated
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                id = try container.decode(Int.self, forKey: .id)
                firstName = try container.decode(String.self, forKey: .firstName)
                lastName = try container.decode(String.self, forKey: .lastName)
                avatar = try container.decode(String.self, forKey: .avatar)
                deactivated = try? container.decodeIfPresent(String.self, forKey: .deactivated)
            }
        }
    }
}
