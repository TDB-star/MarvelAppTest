//
//  DataManager.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 29/03/2022.
//

import Foundation


class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setFavoriteStatus(for comicId: String, with status: Bool) {
        userDefaults.set(status, forKey: "\(comicId)")
    }
    
    func gatFavoritStatus(for comicId: String) -> Bool {
        userDefaults.bool(forKey: "\(comicId)")
    }
}
