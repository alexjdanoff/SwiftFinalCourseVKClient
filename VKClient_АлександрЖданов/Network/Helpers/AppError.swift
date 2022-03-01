//
//  AppError.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 24.02.2022.
//

import Foundation

enum AppError: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
    case notCorrectUrl
}
