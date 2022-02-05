//
//  AllGroupViewController.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 23.11.2021.
//

import UIKit

class AllGroupViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var groupsArray = [Group]()
    
    let customCellReuseIdentifier = "customCellReuseIdentifier"
    let toAllGroupsSegue = "toAllGroupsSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCellGroups", bundle: nil), forCellReuseIdentifier: customCellReuseIdentifier)
        groupFillData()

    }

}
