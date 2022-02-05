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
        tableView.register(UINib(nibName: "NewsTitleTableViewCell", bundle: nil), forCellReuseIdentifier: newsTitleCellReuseIdentifier)
        tableView.register(UINib(nibName: "NewsTextTableViewCell", bundle: nil), forCellReuseIdentifier: newsTextCellReuseIdentifier)
        tableView.register(UINib(nibName: "NewsImageTableViewCell", bundle: nil), forCellReuseIdentifier: newsImageCellReuseIdentifier)
        tableView.register(UINib(nibName: "NewsLikeTableViewCell", bundle: nil), forCellReuseIdentifier: newsLikeCellReuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let titleCell = tableView.dequeueReusableCell(withIdentifier: newsTitleCellReuseIdentifier, for: indexPath) as! NewsTitleTableViewCell
            
            titleCell.avatarImageView.image = newsArray[indexPath.section].avatar
            titleCell.titleLabel.text = newsArray[indexPath.section].name
            titleCell.dateLabel.text = newsArray[indexPath.section].date
            
            return titleCell
        } else if indexPath.row == 1 {
            let textCell = tableView.dequeueReusableCell(withIdentifier: newsTextCellReuseIdentifier, for: indexPath) as! NewsTextTableViewCell
            
            textCell.textView.text = newsArray[indexPath.section].text
            
            return textCell
        } else if indexPath.row == 2 {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: newsImageCellReuseIdentifier, for: indexPath) as! NewsImageTableViewCell

            imageCell.imageNews.image = newsArray[indexPath.section].image
            
            return imageCell
        } else {
            let likeCell = tableView.dequeueReusableCell(withIdentifier: newsLikeCellReuseIdentifier, for: indexPath) as! NewsLikeTableViewCell
            
            likeCell.likeCountLabel.text = newsArray[indexPath.section].likeCount
            likeCell.commentCountLabel.text = newsArray[indexPath.section].commentCount

            
            return likeCell
        }
    }
}
