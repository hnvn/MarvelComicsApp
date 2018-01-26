//
//  CharacterBrowseCoordinator.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/26/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterBrowserCoordinatorDelegate:class {
    func didBrowseCharacter(coordinator: CharacterBrowserCoordinator)
}

class CharacterBrowserCoordinator: Coordinator {
    let navigationController: UINavigationController
    let storyboard: UIStoryboard
    weak var delegate: CharacterBrowserCoordinatorDelegate?
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    }
    
    func start() {
        showCharacterList()
    }
    
    fileprivate func showCharacterList() {
        let vc = storyboard.instantiateViewController(withIdentifier: "CharacterListViewController") as! CharacterListViewController
        vc.viewModel = CharacterListViewModel()
        vc.delegate = self
        navigationController.show(vc, sender: self)
    }
}

extension CharacterBrowserCoordinator: CharacterListViewControllerDelegate {
    
    func didSelectItem(with url: URL) {
        showCharacterDetail(with: url)
    }
    
    fileprivate func showCharacterDetail(with url: URL) {
        let vc = storyboard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        vc.contentUrl = url
        navigationController.show(vc, sender: self)
    }
}
