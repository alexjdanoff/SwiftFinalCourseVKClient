//
//  NewsVC+FillData.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 18.12.2021.
//

import UIKit

extension NewsVC {
    
    func fillNewsArray() {
        
        let newsOne = News(name: "Developers| IT News| Android|IOS|WEB",
                           avatar: "news1_avatar1",
                           text: "Apple представила салфетку для дисплея за 1 990 pyблей. По словам компании, салфетка из мягкого неабразивного материала быстро и качественно очистит любой дисплей Apple, в том числе из стекла с нанотекстурой. Чем обусловлена цена — видимо наличием логотипа Apple.",
                           fotoArray: ["news1_1", "news1_2", "news1_3"])
        let newsTwo = News(name: "IT News",
                           avatar: "news2_avatar",
                           text: "Третий случай взрыва OnePlus Nord 2, снова в Индии oдин из пользователей получил серьёзный ожог ноги после того, как его смартфон взорвался в кармане джинсов. Представители OnePlus уже связались с пострадавшем и пообещали разобраться в инциденте.",
                           fotoArray: ["news2_1", "news2_2", "news2_3", "news2_4"])
        let newsThree = News(name: "Хочу татуировку",
                             avatar: "news3_avatar",
                             text: "hochu tatu 🤘🏻",
                             fotoArray: ["news3_1", "news3_2"])
        
        
        newsArray.append(newsOne)
        newsArray.append(newsTwo)
        newsArray.append(newsThree)
        
    }
    
    
}
