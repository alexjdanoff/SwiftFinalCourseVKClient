//
//  NewsVC.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 18.12.2021.
//

import UIKit

class NewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var newsArray = [News]()
    
    let customCellNewsReuseIdentifier = "customCellNewsReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fillNewsArray()
    }
}
