//
//  NewsVC.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 18.12.2021.
//

import UIKit

class NewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var newsArray: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        GetNewsList().loadData { complition in
            DispatchQueue.main.async {
                self.newsArray = complition
                self.tableView.reloadData()
            }
        }
    }
}
