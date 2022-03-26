//
//  ComicViewModel.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 23/03/2022.
//

import Foundation

protocol DidFinishLoadDelegate: AnyObject {
   func didFinishLoad()
}

protocol ComicListViewModelProtocol {
    var delegate: DidFinishLoadDelegate? { get set}
   
    func loadNextPage()
    func loadComics()
    func getNumberOfComics() -> Int
    func getComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol
    func getComicDetailsViewModel(at indexPath: IndexPath) -> ComicDetailsViewModelProtocol
}

class ComicListViewModel: ComicListViewModelProtocol {
 
    weak var delegate: DidFinishLoadDelegate?
    
    private var comics = [Comic]()
    
    var comicsContainer: ComicDataContainer? {
        didSet {
            didUpdateComicsData()
        }
    }
    
    private let itemsPerPage: Int = 20
    private var currentPage: Int = -1
    private var currentComic: String?

    var isFirstLoad: Bool {
        return currentPage == -1
    }
    
    func loadComics() {
        
        guard isFirstLoad else {
            return
        }
        
        loadComics(at: 0)
    }
    
    func loadNextPage() {
        loadComics(at: (currentPage + 1))
    }
    
    func getNumberOfComics() -> Int {
        return comics.count
    }

    func getComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol {
        let comic = comics[indexPath.item]
        return ComicCellViewModel(comic: comic)
    }
    
    func getComicDetailsViewModel(at indexPath: IndexPath) -> ComicDetailsViewModelProtocol {
        let comic = comics[indexPath.item]
        return ComicDetailsViewModel(comic: comic)
    }
    
    private func loadComics(at page: Int) {
        
        guard self.currentPage != page else {
            return
        }
        
        MVLComicsService.shared.fetchComics(page: page) { result in
            switch result {
            case let .success(comicsContainer):
                self.currentPage = page
                self.comicsContainer = comicsContainer
                self.delegate?.didFinishLoad()
                
            case let .failure(error):
                print("DEBUG: *****\(error.localizedDescription)*****")
            }
        }
    }
    
    private func didUpdateComicsData() {
        if currentPage >= 1 {
            comics.append(contentsOf: comicsContainer!.results )
        } else {
            comics = comicsContainer!.results
        }
        
    }
}
