//
//  MyGroupViewController+TableViewDelegate.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 22.11.2021.
//

import UIKit

extension MyGroupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: nil, message: "Вы уверены что хотите удалить группу?", preferredStyle: .actionSheet)
            let actionYes = UIAlertAction(title: "Да", style: .default) {[weak self] _ in
                guard let self = self else {return}
                self.groupsArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
            alert.addAction(actionYes)
            let actionNo = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
            alert.addAction(actionNo)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
