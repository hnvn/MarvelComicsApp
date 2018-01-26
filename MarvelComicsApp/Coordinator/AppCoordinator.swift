//
//  AppCoordinator.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/26/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {}

class AppCoordinator {
    fileprivate let navigationController:UINavigationController
    fileprivate var childCoordinators = [Coordinator]()
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let characterBrowserCoordinator = CharacterBrowserCoordinator(with: navigationController)
        characterBrowserCoordinator.delegate = self
        characterBrowserCoordinator.start()
        childCoordinators.append(characterBrowserCoordinator)
    }
    
    func removeCoordinator(coordinator:Coordinator) {
        
        var idx:Int?
        for (index,value) in childCoordinators.enumerated() {
            if value === coordinator {
                idx = index
                break
            }
        }
        
        if let index = idx {
            childCoordinators.remove(at: index)
        }
        
    }
}

extension AppCoordinator: CharacterBrowserCoordinatorDelegate {
    func didBrowseCharacter(coordinator: CharacterBrowserCoordinator) {
        removeCoordinator(coordinator: coordinator)
    }
}
