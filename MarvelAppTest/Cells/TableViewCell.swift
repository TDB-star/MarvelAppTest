//
//  TableViewCell.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 28/03/2022.
//

import UIKit

class ComicDescriptionTableViewCell: UITableViewCell {
    
    static let identifier = "ComicDescriptionTableViewCell"
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//var content = cell.defaultContentConfiguration()
//content.text = holidayTitle?.name
//content.secondaryText = holidayTitle?.date
//cell.contentConfiguration = content
