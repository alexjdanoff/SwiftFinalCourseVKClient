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
        tableView.register(UINib(nibName: "NewsTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTitleTableViewCell")
        tableView.register(UINib(nibName: "NewsTextTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTextTableViewCell")
        tableView.register(UINib(nibName: "NewsImageTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsImageTableViewCell")
        tableView.register(UINib(nibName: "NewsLikeTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsLikeTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellsIndex = indexPath.row
        
        switch cellsIndex {
        case 0:
            let titleCell: NewsTitleTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            titleCell.configure(image: newsArray[indexPath.section].avatar, title: newsArray[indexPath.section].name, date: newsArray[indexPath.section].date)
            
            return titleCell
        case 1:
            let textCell: NewsTextTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            textCell.configure(text: newsArray[indexPath.section].text)
            
            return textCell
        case 2:
            let imageCell: NewsImageTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            imageCell.configure(image: newsArray[indexPath.section].image)
            
            return imageCell
        default:
            let likeCell: NewsLikeTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            likeCell.configure(likeCount: newsArray[indexPath.section].likeCount, commentCount: newsArray[indexPath.section].commentCount)
            
            return likeCell
        }
    }
}
