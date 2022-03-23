//
//  CharacterViewModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 21/03/2022.
//

import Foundation

protocol CharacterListViewModelProtocol {
    
    var character: [Character] { get }
   
    
    func fetchCharacters(completion: @escaping() -> Void)
    func getNumberOfItems() -> Int
    func getCharacterCellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol
//    func getCharacterDetailsViewModel(at indexPath: IndexPath) -> getCharacterDetailsViewModelProtocol
}

class CharacterListViewModel: CharacterListViewModelProtocol {

    
    var character: [Character] = []
    
    func fetchCharacters(completion: @escaping () -> Void) {
        MarvelApi.shared.filterHeroes { characters in
            self.character = characters
            completion()
        }
    }
    
    func getNumberOfItems() -> Int {
        character.count
    }
    
    func getCharacterCellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol {
        let character = character[indexPath.item]
        return CharacterCellViewModel(character: character)
    }
    
    
}
