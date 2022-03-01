//
//  MyGroupViewController.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 22.11.2021.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class MyGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var groupsArray: [Group] = []
    var notificationToken: NotificationToken?
    var imageCache: ImageCache?

    var realm: Realm = {
        let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: configrealm)
        return realm
    }()

    lazy var groupsFromRealm: Results<Group> = {
        return realm.objects(Group.self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        subscribeToNotificationRealm()
        GetGroupsList().getData()
        imageCache = ImageCache(container: tableView)
    }
    
    func loadGroupsFromRealm() {
        groupsArray = Array(groupsFromRealm)
        guard groupsFromRealm.count != 0 else { return }
        tableView.reloadData()
    }
    
    private func subscribeToNotificationRealm() {
        notificationToken = groupsFromRealm.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.loadGroupsFromRealm()
            case .update:
                self?.loadGroupsFromRealm()
            case let .error(error):
                print(error)
            }
        }
    }
    
    @objc func addGroup(_ notification: Notification) {
        guard let groupObject = notification.object as? Group else {return}
        
        if groupsArray.contains(where: {sourceGroup in
            sourceGroup.name == groupObject.name
        }) {
            let alert = UIAlertController(title: "Ошибка", message: "Вы уже состоите в данной группе", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil);            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            groupsArray.append(groupObject)
            writeNewGroupToFirebase(groupObject)
            tableView.reloadData()
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func writeNewGroupToFirebase(_ newGroup: Group){
        let database = Database.database()
        let ref: DatabaseReference = database.reference(withPath: "All logged users").child(String(Session.instance.userId))
        
        ref.observe(.value) { snapshot in
            let groupsIDs = snapshot.children.compactMap { $0 as? DataSnapshot }
                .compactMap { $0.key }
            
            guard groupsIDs.contains(String(newGroup.id)) == false else { return }
    
            ref.child(String(newGroup.id)).setValue(newGroup.name)
            print("Для пользователя с ID: \(String(Session.instance.userId)) в Firebase записана группа:\n\(newGroup.name)")
            
            let groups = snapshot.children.compactMap { $0 as? DataSnapshot }
            .compactMap { $0.value }
            print("\nРанее добавленные в Firebase группы пользователя с ID \(String(Session.instance.userId)):\n\(groups)")
            
            ref.removeAllObservers()
        }
    }
}
