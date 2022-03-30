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
    func getComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol
    func getComicDetailsViewModel(at indexPath: IndexPath) -> ComicDetailsViewModelProtocol
    func getFilteredComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol
    func getSctionTypeViewModel(at indexPath: IndexPath) -> SectionTypeViewModelProtocol
    func getFilteredSctionTypeViewModel(at indexPath: IndexPath) -> SectionTypeViewModelProtocol
}

class ComicListViewModel: ComicListViewModelProtocol {
 
    
 
    weak var delegate: DidFinishLoadDelegate?
    
    var comics = [Comic]()
    var filteredComicsArray = [Comic]()
    
    var comicsContainer: ComicDataContainer? {
        didSet {
            didUpdateComicsData()
        }
    }
    
    var isSearching: Bool {
        return !(currentTitle?.isEmpty ?? true)
    }
    
    private let itemsPerPage: Int = 20
    private var currentPage: Int = -1
    private var currentTitle: String?

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
    
    func getNumberOfComics() -> Int {
        return comics.count
    }

    func getComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol {
        let comic = comics[indexPath.item]
        return ComicCellViewModel(comic: comic)
    }
    
    func getFilteredComicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModelProtocol {
        let comic = filteredComicsArray[indexPath.item]
        return ComicCellViewModel(comic: comic)
    }
    
    func getComicDetailsViewModel(at indexPath: IndexPath) -> ComicDetailsViewModelProtocol {
        let comic = comics[indexPath.item]
        return ComicDetailsViewModel(comic: comic)
    }
    
    func getSctionTypeViewModel(at indexPath: IndexPath) -> SectionTypeViewModelProtocol {
        let comic = comics[indexPath.item]
        return SectionTypeViewModel(comic: comic)
    }
    func getFilteredSctionTypeViewModel(at indexPath: IndexPath) -> SectionTypeViewModelProtocol {
        let comic = filteredComicsArray[indexPath.item]
        return SectionTypeViewModel(comic: comic)
    }
    
    private func loadComics(title: String? = nil, at page: Int) {
        
        guard self.currentPage != page else {
            return
        }
        
        MVLComicsService.shared.fetchComics(title, page: page) { result in
            switch result {
            case let .success(comicsContainer):
                self.currentPage = page
                self.currentTitle = title
                self.comicsContainer = comicsContainer
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
}

let terms = ["Hello","Bye","Halo"]

var filterdTerms = [String]()


func filterContentForSearchText(searchText: String) {
    filterdTerms = terms.filter { term in
        return term.lowercased().contains(searchText.lowercased())
    }
}



