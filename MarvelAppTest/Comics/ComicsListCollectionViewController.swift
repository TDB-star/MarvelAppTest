//
//  CharactersCollectionViewController.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import UIKit

class ComicsListCollectionViewController: UICollectionViewController {
    
    // MARK: Variables
    
    private let searchController = UISearchController(searchResultsController: nil)
   
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let itemsPerRow: CGFloat = 2
    
    private var comicsViewModel: ComicListViewModelProtocol!
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }

    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: Lifecycle
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicsViewModel = ComicListViewModel()
        comicsViewModel.loadComics()
        comicsViewModel.delegate = self
        ststusDidChange()
        configureSearhControl()
    }
    
    // MARK: Helpers
    
    private func configureSearhControl() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: Selectors

    @IBAction func updateData(_ sender: UIBarButtonItem) {
        comicsViewModel.loadNextPage()
    }
}

// MARK: UICollectionViewDataSource

extension ComicsListCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            return comicsViewModel.getNumberOfFilteredComics()
        }
        
        return comicsViewModel.getNumberOfComics()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.identifier, for: indexPath) as! ComicCollectionViewCell
        
        if isFiltering {
            cell.comicViewModel = comicsViewModel.getFilteredComicCellViewModel(at: indexPath)
        } else {
            cell.comicViewModel = comicsViewModel.getComicCellViewModel(at: indexPath)
        }
        
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension ComicsListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        var comic: SectionTypeViewModelProtocol
        
        if isFiltering {
             
            comic = comicsViewModel.getFilteredSctionTypeViewModel(at: indexPath)
        } else {
            comic = comicsViewModel.getSctionTypeViewModel(at: indexPath)
        }
        
        let controller = ComicDetailsViewController()
        controller.viewModel = comic
        comic.delegate = self
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension ComicsListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = 1.5 * (widthPerItem) + 66
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
}

// MARK: DidFinishLoadDelegate, StatusDidChangeDelegate

extension ComicsListCollectionViewController: DidFinishLoadDelegate, StatusDidChangeDelegate {
    
    func didFinishLoad() {
        collectionView.reloadData()
    }
    
    func ststusDidChange() {
        collectionView.reloadData()
    }
}

// MARK: UISearchResultsUpdating

extension ComicsListCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    func filterContentForSearchText(_ searchText: String) {
        comicsViewModel.searchComic(with: searchText) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
