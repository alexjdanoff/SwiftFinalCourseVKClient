//
//  MyGroupViewController+TablevViewDataSource.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 22.11.2021.
//

import UIKit

extension MyGroupViewController: UITableViewDataSource {
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCellGroups", bundle: nil), forCellReuseIdentifier: customCellReuseIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(addGroup(_:)), name: Notification.Name("groupSelectedNotification"), object: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCellReuseIdentifier, for: indexPath) as? CustomTableViewCellGroups else {return UITableViewCell()}
        
        cell.configure(group: groupsArray[indexPath.row], clusure: {[weak self] in
            if self != nil {
                NotificationCenter.default.post(name: NSNotification.Name("groupSelectedNotification"), object: self?.groupsArray[indexPath.row])
            }
        })
        
        if let imgUrl = URL(string: groupsArray[indexPath.row].avatar ?? "noImage") {
            cell.avatarImageView.load(url: imgUrl)
        }
        
        cell.addButton.setImage(UIImage(named: "ceckicon2"), for: .normal)
        return cell
    }

}
