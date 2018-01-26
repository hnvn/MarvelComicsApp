//
//  CharacterListViewModel.swift
//  MarvelComicsApp
//
//  Created by Ha Duy Hung on 1/26/18.
//  Copyright © 2018 hunghd. All rights reserved.
//

import Foundation
import RxSwift

class CharacterListViewModel {
    fileprivate let disposeBag = DisposeBag()
    fileprivate let client = Client()
    fileprivate var characters: [CharacterModel]? {
        didSet {
            self.listener?(self.characters!)
        }
    }
    fileprivate var listener: (([CharacterModel]) -> Void)?
    
    func bind(_ listener: @escaping ([CharacterModel]) -> Void) -> Void {
        self.listener = listener
    }
    
    func fetchData() -> Void {
        client
            .request(API.getCharacterList(limit: 30, offset: 0))
            .subscribe(
                onSuccess: { [weak self] response in
                    if (response.code == 200) {
                        if let data = response.data {
                            var array = [CharacterModel]()
                            for character in data.results {
                                var detailUrl = ""
                                for url in character.urls {
                                    if url.type == "detail" {
                                        detailUrl = url.url
                                    }
                                }
                                array.append(CharacterModel(
                                    thumbnailUrl: URL(string:"\(character.thumbnail.path).\(character.thumbnail.extensionType)")!,
                                    name: character.name,
                                    detailUrl: URL(string:detailUrl)!
                                ))
                            }
                            self?.characters = array
                        }
                    }
                },
                onError: {error in
                    print(error)
            })
            .disposed(by: disposeBag)
    }
}

struct CharacterModel {
    let thumbnailUrl: URL
    let name: String
    let detailUrl: URL
}
