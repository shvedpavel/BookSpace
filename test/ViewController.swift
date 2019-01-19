//
//  ViewController.swift
//  test
//
//  Created by Apple on 06/01/2019.
//  Copyright © 2019 shved. All rights reserved.
//

import UIKit
import MobileCoreServices
import FolioReaderKit
import RealmSwift


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookOne?.tag = Epub.bookOne.rawValue
        self.setCover(self.bookOne, index: 0)
        placesCollectionView.dataSource = self
        placesCollectionView.delegate = self
        
    }
    
    
    
    //Import file
    @IBAction func importFile(_ sender: UIBarButtonItem) {
    
    let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeContent as String], in: .import)
    documentPicker.delegate = self
    documentPicker.allowsMultipleSelection = false
    present(documentPicker, animated: true, completion: nil)
    
    }
    
    
    
    
    
    // Main collection
    @IBOutlet weak var placesCollectionView: UICollectionView!
    
    var places = ["1"]
    var bookURL: URL!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count+1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "placesCell", for: indexPath) as! CollectionViewCell
            return cell
            
        default:
            let cell:PlacesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "placesCell2", for: indexPath) as! PlacesCollectionViewCell
            
            cell.ImageCell.image = UIImage(named: places[indexPath.row-1])
            cell.NameBook.text = "try! FolioReader.getAuthorName()"
            cell.NameAuthor.text = "qwe"
            cell.LaterOnBook.text = "100 страниц"
            cell.BackgroundCell.layer.cornerRadius = 10
            cell.BackgroundCell.layer.masksToBounds = true
            cell.ImageCell.layer.cornerRadius = 10
            cell.ImageCell.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width:3,height: 3)
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 0.2

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeaderCollectionReusableView
                header.headerLabel.text = "My Book"
                return header
    }
    
    @IBAction func BookOption(_ sender: UIButton) {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Редактировать", style: .default, handler: { (_) in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OptionBook")
            self.navigationController?.pushViewController(vc, animated: true)
        })
        let delete = UIAlertAction(title: "Удалить", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        optionMenu.addAction(action)
        optionMenu.addAction(delete)
        optionMenu.addAction(cancel)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var bookOne: UIButton?
   
    // Reader
    let folioReader = FolioReader()
    // Reader config
    private func readerConfiguration(forEpub epub: Epub) -> FolioReaderConfig {
        let config = FolioReaderConfig(withIdentifier: epub.readerIdentifier)
        config.shouldHideNavigationOnTap = epub.shouldHideNavigationOnTap
        config.scrollDirection = epub.scrollDirection
        
        // See more at FolioReaderConfig.swift
        //        config.canChangeScrollDirection = false
        //        config.enableTTS = false
        //        config.displayTitle = true
        //        config.allowSharing = false
        //        config.tintColor = UIColor.blueColor()
        //        config.toolBarTintColor = UIColor.redColor()
        //        config.toolBarBackgroundColor = UIColor.purpleColor()
        //        config.menuTextColor = UIColor.brownColor()
        //        config.menuBackgroundColor = UIColor.lightGrayColor()
        //        config.hidePageIndicator = true
        config.realmConfiguration = Realm.Configuration(fileURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("highlights.realm"))
        
        return config
    }
    
    fileprivate func open(epub: Epub) {
        guard let bookPath = epub.bookPath else {
            return
        }
        
        let readerConfiguration = self.readerConfiguration(forEpub: epub)
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: readerConfiguration, shouldRemoveEpub: false)
    }
    
    private func setCover(_ button: UIButton?, index: Int) {
        guard
            let epub = Epub(rawValue: index),
            let bookPath = epub.bookPath else {
                return
        }
        
        do {
            let image = try FolioReader.getCoverImage(bookPath)
            button?.setBackgroundImage(image, for: .normal)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// IBAction

extension ViewController {
    
    @IBAction func didOpen(_ sender: AnyObject) {
        guard let epub = Epub(rawValue: sender.tag) else {
            return
        }

        self.open(epub: epub)
    }
}

extension ViewController:UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURl = urls.first else { return }
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let sandboxFileUrs = dir.appendingPathComponent(selectedFileURl.lastPathComponent)
        
            if FileManager.default.fileExists(atPath: sandboxFileUrs.path) {
                let nameBook = sandboxFileUrs.lastPathComponent
                
                placesCollectionView.performBatchUpdates({
                    places.append(nameBook)
                    placesCollectionView.insertItems(at: [IndexPath(item: 1, section: 0)])
                }, completion: { _ in
                    self.open(epub: Epub.bookOne)
                })
            }
            else {
                    print("errors")
            }
        }
}



