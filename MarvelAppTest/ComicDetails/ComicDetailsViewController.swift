//
//  ComicDetailsViewController.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 27/03/2022.
//

import UIKit

enum SectionType: Int, CaseIterable {
    case comicPhotos
    case comicInfo
    case comicDetails
    case comicDescription
}

class ComicDetailsViewControllerDemo: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var viewModel: SectionTypeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        
    }
}

extension ComicDetailsViewControllerDemo: UITableViewDataSource, UITableViewDelegate {

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PhotoCarouselTableViewCell.self, forCellReuseIdentifier: PhotoCarouselTableViewCell.identifier)
        tableView.register(ComicInfoTableViewCell.self, forCellReuseIdentifier: ComicInfoTableViewCell.identifier)
        tableView.register(ComicDetailsTableViewCell.self, forCellReuseIdentifier: ComicDetailsTableViewCell.identifier)
        //        tableView.rowHeight = AccountSummaryCell.rowHeight
        //tableView.tableFooterView = UIView()
    
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections = SectionType(rawValue: section)
        var title = ""
        
        switch sections {
        case .comicPhotos:
            title = ""
        case .comicInfo:
            title = ""
        case .comicDetails:
            title = "Creators:"
        case .comicDescription:
            title = "Description:"
        case .none:
            break
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = SectionType(rawValue: section)
        var numberOfRows = 0
        switch sections {
        case .comicPhotos:
            numberOfRows = 1
        case .comicInfo:
            numberOfRows = 1
        case .comicDetails:
            numberOfRows = 1
        case .comicDescription:
            numberOfRows = viewModel.comicDescription.count
        case .none:
            break
        }
       return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType.allCases[indexPath.section]
        switch sectionType {
        case .comicPhotos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCarouselTableViewCell.identifier, for: indexPath) as? PhotoCarouselTableViewCell
            else {
                fatalError()
            }
            cell.viewModel = viewModel.getPhotoSectionType()
            return cell
        case .comicInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicInfoTableViewCell.identifier, for: indexPath) as? ComicInfoTableViewCell else {
                fatalError()
            }
            cell.viewModel = viewModel.getComicInfoSectionType()
            return cell
        case .comicDetails:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicDetailsTableViewCell.identifier, for: indexPath) as? ComicDetailsTableViewCell else {
                fatalError()
            }
            cell.viewModel = viewModel.getComicInfoSectionType()
            return cell
        case .comicDescription:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let description = viewModel.comicDescription[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = description.language
            content.secondaryText = description.text
            cell.contentConfiguration = content
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = SectionType.allCases[indexPath.section]
        
        switch sectionType {
        case .comicPhotos:
            return view.frame.size.width
        case .comicInfo:
            return 140
        case .comicDetails:
            return 120
        case.comicDescription:
           return  UITableView.automaticDimension
        }
    }
}



