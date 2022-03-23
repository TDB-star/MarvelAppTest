//
//  ComicViewModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 23/03/2022.
//

import Foundation

protocol ComicListViewModelProtocol {
    
    var comics: [Comic] { get }
  //  var comicsContainer: ComicDataContainer { get }
    func updateComics()
    func fetchComics(completion: @escaping() -> Void)
    func getNumberOfComics() -> Int
    func getComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol
////    func getComicDetailsViewModel(at indexPath: IndexPath) -> getCharacterDetailsViewModelProtocol
}

class ComicListViewModel: ComicListViewModelProtocol {
    //var comicsContainer =  ComicDataContainer()
    
    var comics = [Comic]()
   
    

    private let itemsPerPage: Int = 20
    private var currentPage: Int = -1
    private var currentComic: String?

    

    var isFirstLoad: Bool {
        return currentPage == -1
    }

    func updateComics() {
        
    }
    
    func fetchComics(completion: @escaping () -> Void) {
        NetworkApiManager.shared.fetchComics { comicsContainer in
            self.comics = comicsContainer.results
            completion()
        }
    }

    func getNumberOfComics() -> Int {
        comics.count
    }

    func getComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol {
        let comic = comics[indexPath.item]
        return ComicCellViewModel(comic: comic)
    }
}
