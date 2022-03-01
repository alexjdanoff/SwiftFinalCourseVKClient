//
//  AllGroupViewController+TableViewDelegate.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 23.11.2021.
//

import UIKit

extension AllGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

