//
//  CharactersCollectionViewController.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import UIKit

private let reuseIdentifier = "CharacterListViewCell"

class ComicsListCollectionViewController: UICollectionViewController, StatusDidChangeDelegate {
   
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let itemsPerRow: CGFloat = 2
    
    private var comicsViewModel: ComicListViewModelProtocol!
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicsViewModel = ComicListViewModel()
        comicsViewModel.loadComics()
        comicsViewModel.delegate = self
        ststusDidChange()

    }

    @IBAction func updateData(_ sender: UIBarButtonItem) {
        comicsViewModel.loadNextPage()
    }
    
}

// MARK: UICollectionViewDataSource

extension ComicsListCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comicsViewModel.getNumberOfComics()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ComicCollectionViewCell
        cell.comicViewModel = comicsViewModel.getComicCellViewModel(at: indexPath)
        //cell.isFavoriteImageView.image =
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    func ststusDidChange() {
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDelegate

extension ComicsListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        let comic = comicsViewModel.getComicDetailsViewModel(at: indexPath)
//        let comicController = ComicDetailsViewController()
//        comicController.detailsViewModel = comic
//        navigationController?.pushViewController(comicController, animated: true)
        var comic = comicsViewModel.getSctionTypeViewModel(at: indexPath)
        let controller = ComicDetailsViewControllerDemo()
        controller.viewModel = comic
        comic.delegate = self
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

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

extension ComicsListCollectionViewController: DidFinishLoadDelegate {
    func didFinishLoad() {
        collectionView.reloadData()
    }
}
