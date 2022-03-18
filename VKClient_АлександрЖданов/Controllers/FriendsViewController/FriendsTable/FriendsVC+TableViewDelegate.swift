//
//  FriendsViewController+TableViewDelegate.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 22.11.2021.
//

import UIKit

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: toGallerySegue, sender: friendsList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == toGallerySegue else { return }
        guard let destination = segue.destination as? GalleryVC else { return }
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let friendInfo = getFriendInfoForCell(indexPath)
            destination.title = friendInfo.name
            destination.ownerID = friendInfo.ownerID
        }
    }
}
