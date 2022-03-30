//
//  FavoriteConicViewController.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 30/03/2022.
//

import UIKit

class FavoriteConicViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       
    }
}

extension FavoriteConicViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteComicTableViewCell.identifier, for: indexPath) as? FavoriteComicTableViewCell
        else {
            fatalError()
        }
        return cell
    }
}
