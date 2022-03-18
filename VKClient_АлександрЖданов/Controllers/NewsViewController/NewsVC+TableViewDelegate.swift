//
//  NewsVC+TableViewDelegate.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 18.12.2021.
//

import UIKit

extension NewsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 45
        } else if indexPath.row == 1 {
            return UITableView.automaticDimension
        } else if indexPath.row == 2 {
            return 355
        } else {
            return 50
        }
    }
    
}
