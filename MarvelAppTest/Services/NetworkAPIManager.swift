//
//  NetworkAPIManager.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 21/03/2022.
//

import Foundation

class MarvelApi {
    static let publicKey = "442d93a738880f5f4d6dda5e01cb531e"
    static let privateKey = "a91b7da176ebca327f744add5e8208388c1b8956"
    
    static let shared = MarvelApi()
    
    private init() {}
    
    enum URLS {
        static let baseUrl = "https://gateway.marvel.com:443/v1/public/characters"
        static let keyParameter = "?apikey=\(publicKey)"
        
        case filterCharacters
        
        var stringValue: String {
            switch self {
            case .filterCharacters:
                return URLS.baseUrl + URLS.keyParameter + hashParameter
            }
        }
        
        var hashParameter: String {
            let timeTamp = Date().currentTimeInMillis()
            return "&ts=\(timeTamp)&hash=" + ("\(timeTamp)\(privateKey)\(publicKey)".md5Value)
        }
    }
    
    func filterHeroes(completion: @escaping (_ characters: [Character]) -> Void) {
            print("url: " + URLS.filterCharacters.stringValue)
        
            guard let url = URL(string: URLS.filterCharacters.stringValue) else { return }
        
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    print(error?.localizedDescription ?? "No description")
                    return
                }
               
                do {
                    let decoder = JSONDecoder()
                    let marvelCharacters = try decoder.decode(APIResult.self, from: data)
                    let characters = marvelCharacters.data.results
                    
                    print("DEBUG: json parsing successful")
                    
                    DispatchQueue.main.async {
                        completion(characters)
                    }
                }
                catch let error {
                    print("Error serialization json", error)
                }
            }
            task.resume()
            
        }
    }



class NetworkApiManager {
    
    static let shared = NetworkApiManager()
    
    static let publicKey = "442d93a738880f5f4d6dda5e01cb531e"
    static let privateKey = "a91b7da176ebca327f744add5e8208388c1b8956"
    
    enum URLS {
        static let baseUrl = "https://gateway.marvel.com:443/v1/public/comics"
        static let keyParameter = "?apikey=\(publicKey)"
        
        case filterComics
        
        var stringValue: String {
            switch self {
            case .filterComics:
                return URLS.baseUrl + URLS.keyParameter + hashParameter
            }
        }
        
        var hashParameter: String {
            let timeTamp = Date().currentTimeInMillis()
            return "&ts=\(timeTamp)&hash=" + ("\(timeTamp)\(privateKey)\(publicKey)".md5Value)
        }
    }
   
    private init() {}
    
    func fetchComics(completion: @escaping (_ characters: ComicDataContainer) -> Void ) {
        print("url: " + URLS.filterComics.stringValue)
    
        guard let url = URL(string: URLS.filterComics.stringValue) else { return }
    
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
           
            do {
                let decoder = JSONDecoder()
                let marvelComics = try decoder.decode(ComicDataWrapper.self, from: data)
                let comics = marvelComics.data 
                
                DispatchQueue.main.async {
                    completion(comics)
                }
            }
            catch let error {
                print("Error serialization json", error)
            }
        }
        task.resume()
      
    }
    
}


/*
To use the offset idea you just have to put that as a parameter for the query. So when you call it you, actually, have to call 10 queries with the different offset parameter.

https://gateway.marvel.com/v1/public/characters?ts=yourtsvalue&apikey=publickeyvalue&hash=hashvalue&limit=100&offset=0

https://gateway.marvel.com/v1/public/characters?ts=yourtsvalue&apikey=publickeyvalue&hash=hashvalue&limit=100&offset=100
*/
