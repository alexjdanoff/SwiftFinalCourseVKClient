//
//  MyGroupViewController+TablevViewDataSource.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 22.11.2021.
//

import UIKit

extension MyGroupsViewController: UITableViewDataSource {
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerWithNib(registerClass: GroupsCell.self)
        NotificationCenter.default.addObserver(self, selector: #selector(addGroup(_:)), name: Notification.Name("groupSelectedNotification"), object: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GroupsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.configure(group: groupsArray[indexPath.row], clusure: {[weak self] in
            if self != nil {
                NotificationCenter.default.post(name: NSNotification.Name("groupSelectedNotification"), object: self?.groupsArray[indexPath.row])
            }
        })
        
        guard let imgUrl = groupsArray[indexPath.row].avatar else { return cell }
        if cell.avatarImageView.image == nil {
            cell.avatarImageView.image = imageCache?.photo(atIndexPath: indexPath, byUrl: imgUrl)
        } else {
            cell.avatarImageView.image = UIImage(named: imgUrl)
        }
        
        cell.addButton.setImage(UIImage(named: "ceckicon2"), for: .normal)
        return cell
    }
    
}
