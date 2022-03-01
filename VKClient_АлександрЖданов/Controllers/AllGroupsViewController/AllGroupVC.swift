//
//  AllGroupViewController.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 23.11.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var groupsArray = [Group]()
    let toAllGroupsSegue = "toAllGroupsSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerWithNib(registerClass: GroupsCell.self)
        groupFillData()

    }

}
