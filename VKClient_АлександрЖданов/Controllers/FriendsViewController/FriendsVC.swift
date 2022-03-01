//
//  FriendsViewController.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 22.11.2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let toGallerySegue = "toGallerySegue"
    
    var friendsList: [Friend] = []
    var namesListFixed: [String] = []
    var namesListModifed: [String] = []
    var letersOfNames: [String] = []
    var notificationToken: NotificationToken?
    var imageCache: ImageCache?
    
    var realm: Realm = {
        let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: configrealm)
        return realm
    }()

    lazy var friendsFromRealm: Results<Friend> = {
        return realm.objects(Friend.self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        subscribeToNotificationRealm()
        GetFriendsList().getData()
        imageCache = ImageCache(container: tableView)
    }
    
    private func subscribeToNotificationRealm() {
        notificationToken = friendsFromRealm.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.loadFriendsFromRealm()
            case .update:
                self?.loadFriendsFromRealm()
            case let .error(error):
                print(error)
            }
        }
    }
    
    func loadFriendsFromRealm() {
        friendsList = Array(friendsFromRealm).sorted{ $0.name < $1.name }
        guard friendsList.count != 0 else { return }
        makeNamesList()
        sortCharacterOfNamesAlphabet()
        tableView.reloadData()
    }
    
    func makeNamesList() {
        namesListFixed.removeAll()
        for item in 0...(friendsList.count - 1){
            namesListFixed.append(friendsList[item].name)
        }
        namesListModifed = namesListFixed
    }
    
    func sortCharacterOfNamesAlphabet() {
        var letersSet = Set<Character>()
        letersOfNames = []

        for name in namesListModifed {
            letersSet.insert(name[name.startIndex])
        }
        
        for leter in letersSet.sorted() {
            letersOfNames.append(String(leter))
        }
    }
    
    func getFriendInfoForCell(_ indexPath: IndexPath) -> (name: String, avatar: URL?, ownerID: String) {
        var friendInfo: [(name: String, avatar: URL?, ownerID: String)] = []
        let letter = letersOfNames[indexPath.section]
        
        for friend in friendsList {
            if letter.contains(friend.name.first!){
                let name = friend.name
                let avatar = URL(string: friend.avatar)
                let ownerID = friend.ownerID
                
                friendInfo.append((name, avatar, ownerID))
            }
        }
        return friendInfo[indexPath.row]
    }
}
