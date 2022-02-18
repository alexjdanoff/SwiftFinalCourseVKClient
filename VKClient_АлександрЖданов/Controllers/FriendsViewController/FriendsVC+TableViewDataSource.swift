//
//  FriendsViewController+TableViewDataSource.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 22.11.2021.
//

import UIKit

extension FriendsViewController: UITableViewDataSource {
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.registerWithNib(registerClass: CustomTableViewCellFriends.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return letersOfNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countOfRows = 0
        for name in namesListModifed {
            if letersOfNames[section].contains(name.first!) {
                countOfRows += 1
            }
        }
        return countOfRows
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        let leter: UILabel = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
        leter.textColor = UIColor.black.withAlphaComponent(0.5)
        leter.text = letersOfNames[section]
        leter.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        header.addSubview(leter)
        
        return header
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letersOfNames
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCellFriends = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        let friendInfo = getFriendInfoForCell(indexPath)
        cell.nameLabel.text = friendInfo.name

        guard let imgUrl = friendInfo.avatar else { return cell }
        cell.avatarImageView.image = imageCache?.photo(atIndexPath: indexPath, byUrl: String("\(imgUrl)"))
        
        return cell
    }
    
}
