//
//  GetPhotosFriend.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 29.12.2021.
//

import Foundation

class GetPhotosFriend {
    
    func loadData(_ ownerID: String) {
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: ownerID),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let arrayPhotosFriend = try JSONDecoder().decode(PhotosResponse.self, from: data)
                var photosFriend: [Photo] = []
                var ownerID = ""
                
                if arrayPhotosFriend.response.items.count > 0 {
                    for i in 0...arrayPhotosFriend.response.items.count - 1 {
                        if let urlPhoto = arrayPhotosFriend.response.items[i].sizes.last?.url {
                            ownerID = String(arrayPhotosFriend.response.items[i].ownerID)
                            photosFriend.append(Photo.init(photo: urlPhoto, ownerID: ownerID))
                        }
                    }
                } else {
                    photosFriend.append(Photo.init(photo: "noImage", ownerID: ownerID))
                }
                DispatchQueue.main.async {
                    RealmOperations().savePhotosToRealm(photosFriend, ownerID)
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
}
