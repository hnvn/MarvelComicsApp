//
//  ViewController.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/25/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import UIKit
import RxSwift
import AlamofireImage

protocol CharacterListViewControllerDelegate:class {
    func didSelectItem(with url: URL)
}

class CharacterListViewController: UIViewController {
    
    public var viewModel: CharacterListViewModel?
    public weak var delegate: CharacterListViewControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var characters: [CharacterModel]?
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
        setupViewModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() -> Void {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func setupViewModels() -> Void {
        self.viewModel?.bind { [weak self] characters in
            self?.characters = characters
            self?.collectionView.reloadData()
        }
        self.viewModel?.fetchData()
    }
}

// MARK: UICollectionViewDataSource
extension CharacterListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let characters = characters {
            return characters.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterViewCell", for: indexPath) as! CharacterViewCell
        if let characters = characters, characters.count > indexPath.row {
            let character = characters[indexPath.row]
            cell.thumbnail.af_setImage(withURL: character.thumbnailUrl)
            cell.name.text = character.name
        }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let characters = characters, indexPath.row < characters.count {
            self.delegate?.didSelectItem(with: characters[indexPath.row].detailUrl)
        }
    }
}

// MARK: Customize UICollectionViewCell
class CharacterViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
}

