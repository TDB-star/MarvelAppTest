//
//  CharactersCollectionViewController.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 22/03/2022.
//

import UIKit

private let reuseIdentifier = "CharacterListViewCell"

class CharactersCollectionViewController: UICollectionViewController, DidFinishLoadDelegate {
   
    
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let itemsPerRow: CGFloat = 2
    
//    private var viewModel: CharacterListViewModelProtocol! {
//        didSet {
//            viewModel.fetchCharacters {
//                self.collectionView.reloadData()
//            }
//        }
//    }
    
    private var comicsViewModel: ComicListViewModelProtocol! {
        didSet {
//            comicsViewModel.fetchComics {
//                self.collectionView.reloadData()
//            }
//            comicsViewModel.loadComics {
//                self.collectionView.reloadData()
//            }
        }
    }

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
        print(comicsViewModel.getNumberOfComics())
       //viewModel = CharacterListViewModel()
        
    
    }

    func didFinishLoad() {
        collectionView.reloadData()
    }
    
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        comicsViewModel.loadNextPage()
    }
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //viewModel.getNumberOfItems()
        comicsViewModel.getNumberOfComics()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        //cell.viewModel = viewModel.getCharacterCellViewModel(at: indexPath)
        cell.comicViewModel = comicsViewModel.getComicCellViewModel(at: indexPath)
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }

    // MARK: UICollectionViewDelegate

}

extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem + 100
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
}
