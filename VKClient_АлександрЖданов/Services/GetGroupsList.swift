//
//  GetGroupsList.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 29.12.2021.
//

import Foundation

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

class GetGroupsList {
    
    func loadData() {
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let arrayGroups = try JSONDecoder().decode(GroupsResponse.self, from: data)
                var groupList: [Group] = []
                for i in 0...arrayGroups.response.items.count - 1 {
                    let name = ((arrayGroups.response.items[i].name))
                    let logo = arrayGroups.response.items[i].logo
                    let id = arrayGroups.response.items[i].id
                    groupList.append(Group.init(name: name, avatar: logo, id: id))
                }
                
                DispatchQueue.main.async {
                    RealmOperations().saveGroupsToRealm(groupList)
                }
                
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
