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
        tableView.prefetchDataSource = self
        tableView.registerWithNib(registerClass: NewsTitleCell.self)
        tableView.registerWithNib(registerClass: NewsTextCell.self)
        tableView.registerWithNib(registerClass: NewsImageCell.self)
        tableView.registerWithNib(registerClass: NewsLikeCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellsIndex = Cells.init(rawValue: indexPath.row)
        let arrayIndex = newsArray[indexPath.section]

        switch cellsIndex {
        case .titleCell:
            let cell: NewsTitleCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(arrayIndex)
            let image = imageCache?.photo(atIndexPath: indexPath, byUrl: arrayIndex.avatarURL ?? "")
            cell.configure(image)
            return cell
        case .textCell:
            let cell: NewsTextCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(arrayIndex)
            cell.showMoreButton.addTarget(self, action: #selector(resizeTextCell), for: .touchUpInside)
            self.indexPaths = [indexPath]
            return cell
        case .imageCell:
            let cell: NewsImageCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            guard let urlImage = arrayIndex.photosURL?.first else { return UITableViewCell() }
            let image = imageCache?.photo(atIndexPath: indexPath, byUrl: urlImage)
            cell.configure(image)
            return cell
        case .likeCell:
            let cell: NewsLikeCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(arrayIndex)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc func resizeTextCell() {
          tableView.reloadRows(at: indexPaths, with: .automatic)
      }
}

