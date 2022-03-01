//
//  NewsVC+TableViewDelegate.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 18.12.2021.
//

import UIKit

extension NewsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellsIndex = Cells.init(rawValue: indexPath.row)
        let arrayIndex = newsArray[indexPath.section]
        
        switch cellsIndex {
        case .titleCell:
            return 45
        case .textCell:
            if arrayIndex.text!.isEmpty {
                return 0
            }
            return UITableView.automaticDimension
        case .imageCell:
            guard let urls = arrayIndex.photosURL,
                  !urls.isEmpty else {
                      return 0
                  }
            let width = view.frame.width
            let post = arrayIndex
            let cellHeight = width * post.aspectRatio
            return cellHeight
        case .likeCell:
            return 50
        default:
            return UITableView.automaticDimension
        }
    }
}
