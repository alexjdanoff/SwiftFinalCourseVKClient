//
//  NewsVC+TableViewDataSource.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 18.12.2021.
//

import UIKit

extension NewsVC: UITableViewDataSource {
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerWithNib(registerClass: NewsTitleTableViewCell.self)
        tableView.registerWithNib(registerClass: NewsTextTableViewCell.self)
        tableView.registerWithNib(registerClass: NewsImageTableViewCell.self)
        tableView.registerWithNib(registerClass: NewsLikeTableViewCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellsIndex = indexPath.row
        let arrayIndex = newsArray[indexPath.section]
        
        switch cellsIndex {
        case 0:
            let titleCell: NewsTitleTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            titleCell.configure(arrayIndex)
            let image = imageCache?.photo(atIndexPath: indexPath, byUrl: arrayIndex.avatar)
            titleCell.configure(image)
            return titleCell
        case 1:
            let textCell: NewsTextTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            textCell.configure(arrayIndex)
            return textCell
        case 2:
            let imageCell: NewsImageTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            guard let urlImage = arrayIndex.image else { return UITableViewCell() }
            let image = imageCache?.photo(atIndexPath: indexPath, byUrl: urlImage)
            imageCell.configure(image)
            return imageCell
        default:
            let likeCell: NewsLikeTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            likeCell.configure(arrayIndex)
            return likeCell
        }
    }
}
