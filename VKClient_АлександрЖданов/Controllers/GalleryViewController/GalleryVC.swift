//
//  GalleryVC.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 25.11.2021.
//

import UIKit
import RealmSwift

class GalleryVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifer = "reuseIdentifer"
    let toFullGallary = "toFullGallary"
    
    var ownerID = ""
    var collectionPhotos: [Photo] = []
    
    var realm: Realm = {
        let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: configrealm)
        return realm
    }()
    
    lazy var photosFromRealm: Results<Photo> = {
        return realm.objects(Photo.self).filter("ownerID == %@", ownerID)
    }()
    
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        subscribeToNotificationRealm()
        GetPhotosFriend().loadData(ownerID)
    }
    
    func loadPhotosFromRealm() {
        do {
            let realm = try Realm()
            let photosFromRealm = realm.objects(Photo.self).filter("ownerID == %@", ownerID)
            collectionPhotos = Array(photosFromRealm)
            guard collectionPhotos.count != 0 else { return } // проверка, что в реалме что-то есть
            collectionView.reloadData()
        } catch {
            print(error)
        }
    }
    
    private func subscribeToNotificationRealm() {
        notificationToken = photosFromRealm.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.loadPhotosFromRealm()
            case .update:
                self?.loadPhotosFromRealm()
            case let .error(error):
                print(error)
            }
        }
    }
    
}
