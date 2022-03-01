//
//  FriendsVC+SearchBarDelegate.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 05.01.2022.
//

import UIKit

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        namesListModifed = searchText.isEmpty ? namesListFixed : namesListFixed.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        sortCharacterOfNamesAlphabet()
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        makeNamesList()
        sortCharacterOfNamesAlphabet()
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

