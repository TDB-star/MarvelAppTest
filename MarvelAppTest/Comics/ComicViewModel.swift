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
    var comics: [Comic] { get }
    var filteredComicsArray: [Comic] { get }
    func loadNextPage()
    func loadComics()
    func searchComic(with title: String, completion: @escaping () -> Void)
    func getNumberOfComics() -> Int
    func getNumberOfFilteredComics() -> Int
    
    func getComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol
    func getFilteredComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol
    
    func getSctionTypeViewModel(at indexPath: IndexPath) -> SectionTypeViewModelProtocol
    func getFilteredSctionTypeViewModel(at indexPath: IndexPath) -> SectionTypeViewModelProtocol
}

class ComicListViewModel: ComicListViewModelProtocol {
  
    weak var delegate: DidFinishLoadDelegate?
    
    var comics = [Comic]()
    var filteredComicsArray = [Comic]()
    
    private var comicsContainer: ComicDataContainer? {
        didSet {
            didUpdateComicsData()
        }
    }
    
    private var currentPage: Int = -1

    var isFirstLoad: Bool {
        return currentPage == -1
    }
    
    func searchComic(with title: String, completion: @escaping () -> Void ) {
        filteredComicsArray = comics.filter { term in
            return term.title.lowercased().contains(title.lowercased())
        }
        completion()
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
    
    private func loadComics(at page: Int) {
        
        guard self.currentPage != page else {
            return
        }
        
        MVLComicsService.shared.fetchComics(page: page) { result in
            switch result {
            case let .success(comicsContainer):
                self.currentPage = page
                self.comicsContainer = comicsContainer
                //self.comics = comicsContainer.results
                self.delegate?.didFinishLoad()
                
            case let .failure(error):
                print("DEBUG: \(error.localizedDescription)")
            }
        }
    }
    
    private func didUpdateComicsData() {
        if currentPage >= 1 {
            comics.append(contentsOf: comicsContainer?.results ?? [] )
        } else {
            comics = comicsContainer?.results ?? []
        }
    }
    
    func getNumberOfComics() -> Int {
        return comics.count
    }
    func getNumberOfFilteredComics() -> Int {
        return filteredComicsArray.count
    }

    func getComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol {
        let comic = comics[indexPath.item]
        return ComicCellViewModel(comic: comic)
    }
    
    func getFilteredComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol {
        let comic = filteredComicsArray[indexPath.item]
        return ComicCellViewModel(comic: comic)
    }
    
    func getSctionTypeViewModel(at indexPath: IndexPath) -> SectionTypeViewModelProtocol {
        let comic = comics[indexPath.item]
        return SectionTypeViewModel(comic: comic)
    }
    func getFilteredSctionTypeViewModel(at indexPath: IndexPath) -> SectionTypeViewModelProtocol {
        let comic = filteredComicsArray[indexPath.item]
        return SectionTypeViewModel(comic: comic)
    }
}




