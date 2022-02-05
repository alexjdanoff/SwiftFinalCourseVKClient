//
//  NewsVC.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 18.12.2021.
//

import UIKit

class NewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let newsTitleCellReuseIdentifier = "newsTitleCellReuseIdentifier"
    let newsTextCellReuseIdentifier = "newsTextCellReuseIdentifier"
    let newsImageCellReuseIdentifier = "newsImageCellReuseIdentifier"
    let newsLikeCellReuseIdentifier = "newsLikeCellReuseIdentifier"
    
    var newsArray = [
    News(name: "Developers| IT News| Android|IOS|WEB",
         avatar: UIImage(named: "news1_avatar1"),
         date: "04.02.2022 в 17:55",
         text: "Apple представила салфетку для дисплея за 1 990 pyблей. По словам компании, салфетка из мягкого неабразивного материала быстро и качественно очистит любой дисплей Apple, в том числе из стекла с нанотекстурой. Чем обусловлена цена — видимо наличием логотипа Apple.", image: UIImage(named: "news1_1"),
         likeCount: "12",
         commentCount: "3"),
    News(name: "IT News",
         avatar: UIImage(named: "news2_avatar"),
         date: "23.01.2022 в 23:14",
         text: "Третий случай взрыва OnePlus Nord 2, снова в Индии oдин из пользователей получил серьёзный ожог ноги после того, как его смартфон взорвался в кармане джинсов. Представители OnePlus уже связались с пострадавшем и пообещали разобраться в инциденте.",
         image: UIImage(named: "news2_1"),
         likeCount: "23",
         commentCount: ""),
    News(name: "Хочу татуировку",
         avatar: UIImage(named: "news3_avatar"),
         date: "05.12.2021 в 12:01",
         text: "hochu tatu 🤘🏻",
         image: UIImage(named: "news3_1"),
         likeCount: "36",
         commentCount: "12")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}
