//
//  GetGroupsList+SaveDataToRealm.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 12.02.2022.
//

import Foundation

final class SaveDataToRealm: Operation {
    
    override func main() {
        guard let operation = dependencies.first as? ParseJsonData,
              let data = operation.dataFromJson
        else { return }
        OperationQueue.main.addOperation {
            RealmOperations().saveGroupsToRealm(data)
        }
    }
}
