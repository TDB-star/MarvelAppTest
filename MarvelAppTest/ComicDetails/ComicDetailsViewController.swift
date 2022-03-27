//
//  ComicDetailsViewController.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 27/03/2022.
//

import UIKit

enum SectionType {
    case comicPhotos(with: ComicDetailsViewModelProtocol)
    case comicInfo
    case comicDetails
    case variantCover
}

class ComicDetailsViewControllerDemo: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var viewModel: SectionTypeViewModelProtocol!
    private var sections = [SectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        configureSection()
        
    }
    
    private func configureSection() {
        sections.append(.comicPhotos(with: viewModel.getPhotoSectionType()))
        sections.append(.comicInfo)
        sections.append(.comicDetails)
        sections.append(.variantCover)
    }
}

extension ComicDetailsViewControllerDemo: UITableViewDataSource, UITableViewDelegate {

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PhotoCarouselTableViewCell.self, forCellReuseIdentifier: PhotoCarouselTableViewCell.identifier)
        //
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
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .comicPhotos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCarouselTableViewCell.identifier, for: indexPath) as? PhotoCarouselTableViewCell
            else {
                fatalError()
            }
            cell.viewModel = viewModel.getPhotoSectionType()
            return cell
        case .comicInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "test"
        case .comicDetails:
            break
        case .variantCover:
            break
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .comicPhotos:
            return view.frame.size.width
        case .comicInfo:
            return UITableView.automaticDimension
        case .comicDetails:
            return UITableView.automaticDimension
        case.variantCover:
           return  UITableView.automaticDimension
           
        }
    }
}


