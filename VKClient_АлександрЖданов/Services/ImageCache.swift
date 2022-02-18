//
//  ImageCache.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 17.02.2022.
//

import UIKit
import Alamofire

class ImageCache {
    
    private var images = [String: UIImage]()
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60 //Время хранения нашего кеша
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    //Задаем папку в которой будут сохраняться изображения
    private static let pathName: String = {
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    //показываем изображение в зависимости от его местонахождения
    func photo(atIndexPath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        print(url)
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexPath: indexPath, byUrl: url)
        }
        
        return image
    }
    //загружаем изображение из файловой системы
    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        
        return image
    }
    //получаем на вход URL изображения и возвращаем на его основе путь к файлу для сохранения или загрузки
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(ImageCache.pathName + "/" + hashName).path
    }
    //загружаем изоброжение из сети и сохраняем на диске
    private func loadPhoto(atIndexPath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: .global()) { [weak self] response in
            guard let data = response.data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            
            self?.saveImageToCache(url: url, image: image)
            
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexPath: indexPath)
            }
            
        }
    }
    //сохраняем изображение в файловой системе
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        
        print(fileName)
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexPath indexPath: IndexPath)
}

extension ImageCache {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
