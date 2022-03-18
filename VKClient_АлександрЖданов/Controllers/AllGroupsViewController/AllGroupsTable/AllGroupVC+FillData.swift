//
//  AllGroupVC+FillData.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 08.12.2021.
//

import UIKit

extension AllGroupsViewController {
    
    func groupFillData() {
        let groupOne = Group(name: "Сar enthusiasts", avatar: "avtolb4", id: 1111)
        let groupTwo = Group(name: "Basketball fans", avatar: "basket1", id: 2222)
        let groupThree = Group(name: "IT world", avatar: "it1", id: 3333)
        let groupFour = Group(name: "Nails", avatar: "nails1", id: 4444)
        let groupFive = Group(name: "Shopping", avatar: "shopping1", id: 5555)
        
        groupsArray.append(groupOne)
        groupsArray.append(groupTwo)
        groupsArray.append(groupThree)
        groupsArray.append(groupFour)
        groupsArray.append(groupFive)
    }
}
