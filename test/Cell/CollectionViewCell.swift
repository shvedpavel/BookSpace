//
//  CollectionViewCell.swift
//  test
//
//  Created by Apple on 07/01/2019.
//  Copyright © 2019 shved. All rights reserved.
//

import UIKit





class CollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var FirstCollection: UICollectionView!
    
    
    var places = [String] ()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.FirstCollection.delegate = self
        self.FirstCollection.dataSource = self
        
        places = ["Pl1","Pl2","Pl3","Pl4","Pl5"]
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CellInCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellInCollectionViewCell
        
        cell.ImageInCell.image = UIImage(named: places[indexPath.row])
        cell.ImageInCell.layer.cornerRadius = 10
        cell.ImageInCell.layer.masksToBounds = true
        cell.NameBook.text = "Название"
        cell.BookAuthorName.text = "Автор"
        cell.CompleteBook.text = "20% прочитано"
        cell.BackgroundCell.layer.cornerRadius = 10
        cell.BackgroundCell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width:3,height: 3)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 0.2
        
        return cell
    }
    
}
