//
//  GetGroupListOperation.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 11.02.2022.
//

import Foundation
import RealmSwift

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

final class GetGroupsList {
    
    lazy var operationQueue = OperationQueue()
    
    func getData() {
        let loadedJsonFromVK = LoadJsonData()
        let parsedDataFromJson = ParseJsonData()
        let saveData = SaveDataToRealm()
        
        parsedDataFromJson.addDependency(loadedJsonFromVK)
        saveData.addDependency(parsedDataFromJson)
        
        let operations = [loadedJsonFromVK, parsedDataFromJson, saveData]
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    class OperationsAsync: Operation {
        
        enum State: String {
            case ready, executing, finished
            fileprivate var keyPath: String {
                return "is" + rawValue.capitalized
            }
        }
        
        var state = State.ready {
            willSet {
                willChangeValue(forKey: state.keyPath)
                willChangeValue(forKey: newValue.keyPath)
            }
            didSet {
                didChangeValue(forKey: state.keyPath)
                didChangeValue(forKey: oldValue.keyPath)
            }
        }
        
        override var isAsynchronous: Bool {
            return true
        }
        
        override var isReady: Bool {
            return super.isReady && state == .ready
        }
        
        override var isExecuting: Bool {
            return state == .executing
        }
        
        override var isFinished: Bool {
            return state == .finished
        }
        
        override func start() {
            if isCancelled {
                state = .finished
            } else {
                main()
                state = .executing
            }
        }
        
        override func cancel() {
            super.cancel()
            state = .finished
        }
    }
    
    
    final class LoadJsonData: OperationsAsync {
        
        var jsonFromVK: Data?
        var errorFromVK: Error?
        
        override func main() {
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
                URLQueryItem(name: "v", value: "5.122")
            ]
            
            let task = session.dataTask(with: urlConstructor.url!) { [weak self] (data, _, error) in
                //print("Запрос к API: \(urlConstructor.url!)")
                guard let data = data else { return }
                
                self?.jsonFromVK = data
                self?.errorFromVK = error
                self?.state = .finished
            }
            task.resume()
        }
    }
    
    
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
    
    
    final class SaveDataToRealm: Operation {
        
        override func main() {
            guard let operation = dependencies.first as? ParseJsonData,
                  let data = operation.dataFromJson
            else { return }
            DispatchQueue.main.async {
                RealmOperations().saveGroupsToRealm(data)
            }
        }
    }
    
}
