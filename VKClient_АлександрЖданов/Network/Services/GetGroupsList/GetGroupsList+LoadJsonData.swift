//
//  GetGroupsList+LoadJsonData.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 12.02.2022.
//

import Foundation

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
