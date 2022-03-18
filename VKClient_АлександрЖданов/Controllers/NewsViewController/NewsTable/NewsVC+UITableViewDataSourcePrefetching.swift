//
//  NewsVC+UITableViewDataSourcePrefetching.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 25.02.2022.
//

import UIKit

extension NewsVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else {
            return
        }
        
        if maxSection > newsArray.count - 3,
           !isLoading {
            isLoading = true
            
            service.getUrl(self.nextForm)
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
                    let indexSet = IndexSet(integersIn: self.newsArray.count..<self.newsArray.count + news.count)
                    
                    self.newsArray.append(contentsOf: news)
                    self.tableView.insertSections(indexSet, with: .automatic)
                }.ensure {
                    self.isLoading = false
                }.catch { error in
                    print(error)
                }
        }
    }
    
}
