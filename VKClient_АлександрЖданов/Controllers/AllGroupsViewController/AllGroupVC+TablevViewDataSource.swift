//
//  AllGroupViewController+TablevViewDataSource.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 23.11.2021.
//

import UIKit

extension AllGroupViewController: UITableViewDataSource {
    
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
        return cell
    }

}
