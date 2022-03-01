//
//  GetGroupListOperation.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 11.02.2022.
//

import Foundation

final class GetGroupsList {
    
    var operationQueue = OperationQueue()
    
    func getData() {
        let loadedJsonFromVK = LoadJsonData()
        let parsedDataFromJson = ParseJsonData()
        let saveData = SaveDataToRealm()
        
        parsedDataFromJson.addDependency(loadedJsonFromVK)
        saveData.addDependency(parsedDataFromJson)
        
        let operations = [loadedJsonFromVK, parsedDataFromJson, saveData]
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
}
