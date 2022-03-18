//
//  NewsVC.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 18.12.2021.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var newsArray: [News] = []
    var imageCache: ImageCache?
    let service = NetworkingService()
    private var lastDateString: String?
    var nextForm = ""
    var isLoading = false
    var indexPaths = [IndexPath]()
    
    enum Cells: Int {
        case titleCell
        case textCell
        case imageCell
        case likeCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        imageCache = ImageCache(container: tableView)
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        service.getUrl()
            .get({ url in
                print(url)
            })
            .then(on: DispatchQueue.global(), service.getData(_:))
            .then(on: DispatchQueue.global(), service.getParsedData(_:))
            .get({ response in
                self.nextForm = response.nextFrom ?? ""
            })
            .then(on: DispatchQueue.global(), service.getNews(_:))
            .done(on: DispatchQueue.main) { [weak self] news in
                guard let self = self else { return }
                self.newsArray = news
                self.tableView.reloadData()
                self.lastDateString = String(news.first?.date ?? 0)
            }.ensure {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }.catch { error in
                print(error)
            }
    }
    
    
    fileprivate func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        tableView.refreshControl?.tintColor = .gray
        tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc func refreshNews() {
        guard let date = lastDateString else {
            tableView.refreshControl?.endRefreshing()
            return
        }
        
        service.getUrlWithTime(date)
            .get({ url in
                print(url)
            })
            .then(on: DispatchQueue.global(), service.getData(_:))
            .then(on: DispatchQueue.global(), service.getParsedData(_:))
            .then(on: DispatchQueue.global(), service.getNews(_:))
            .done(on: DispatchQueue.main) { [weak self] news in
                guard let self = self else { return }
                print(news.count)
                let indexSet = IndexSet(integersIn: self.newsArray.count..<self.newsArray.count + news.count)
                self.newsArray.insert(contentsOf: news, at: 0)
                self.tableView.insertSections(indexSet, with: .automatic)
                self.lastDateString = news.first?.getStringDate()
            }.ensure { [weak self] in
                self?.tableView.refreshControl?.endRefreshing()
            }.catch { error in
                print(error)
            }
    }
}
