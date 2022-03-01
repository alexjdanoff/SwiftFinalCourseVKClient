//
//  RealmOperations.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 06.01.2022.
//

import Foundation
import RealmSwift

class RealmOperations {

    func saveFriendsToRealm(_ friendList: [Friend]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldFriendList = realm.objects(Friend.self)
                realm.delete(oldFriendList)
                realm.add(friendList)
//                print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
    
    func savePhotosToRealm(_ photoList: [Photo], _ ownerID: String) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldPhotoList = realm.objects(Photo.self).filter("ownerID == %@", ownerID)
                realm.delete(oldPhotoList)
                realm.add(photoList)
            }
        } catch {
            print(error)
        }
    }
        
    func saveGroupsToRealm(_ groupList: [Group]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldGroupsList = realm.objects(Group.self)
                realm.delete(oldGroupsList)
                realm.add(groupList)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAllFromRealm() {
        do {
            let realm = try Realm()
            try realm.write{
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
}
