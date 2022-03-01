//
//  GetGroupsList+ParseJsonData.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 12.02.2022.
//

import Foundation

final class ParseJsonData: Operation {
    
    var dataFromJson: [Group]?
    var errorFromJson: Error?
    
    override func main() {
        guard let operation = dependencies.first as? LoadJsonData,
              let data = operation.jsonFromVK
        else { return }
        
        do {
            let arrayGroups = try JSONDecoder().decode(GroupsResponse.self, from: data)
            var grougList: [Group] = []
            for i in 0...arrayGroups.response.items.count - 1 {
                let name = ((arrayGroups.response.items[i].name))
                let logo = arrayGroups.response.items[i].logo
                let id = arrayGroups.response.items[i].id
                grougList.append(Group.init(name: name, avatar: logo, id: id))
            }
            
            dataFromJson = grougList
        } catch let error {
            errorFromJson = error
            print(error.localizedDescription )
        }
    }
}
