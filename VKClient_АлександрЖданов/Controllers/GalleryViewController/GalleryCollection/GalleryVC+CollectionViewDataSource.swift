//
//  GalleryVC+CollectionViewDataSource.swift
//  VKClient_АлександрЖданов
//
//  Created by Alexandru Jdanov on 07.12.2021.
//

import UIKit

extension GalleryVC: UICollectionViewDataSource {
    
    func configureCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        self.navigationController?.delegate = self
        collectionView.register(UINib(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifer)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as? GalleryCell else {return UICollectionViewCell()}
        
        if let imgUrl = URL(string: collectionPhotos[indexPath.row].photo) {
            cell.fotoImageView.load(url: imgUrl)
        }
        return cell
    }
}
