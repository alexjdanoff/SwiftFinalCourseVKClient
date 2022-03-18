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

struct PhotosResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var count: Int
        var items: [Item]
        
        struct Item: Decodable {
            var ownerID: Int
            var sizes: [Sizes]
            
            private enum CodingKeys: String, CodingKey {
                case ownerID = "owner_id"
                case sizes
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                ownerID = try container.decode(Int.self, forKey: .ownerID)
                sizes = try container.decode([Sizes].self, forKey: .sizes)
            }
            
            struct Sizes: Decodable {
                var url: String
            }
        }
    }
}
