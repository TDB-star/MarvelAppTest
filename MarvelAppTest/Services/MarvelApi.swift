//
//  MarvelApi.swift
//  MarvelAppTest
//
//  Created by Tatiana Dmitrieva on 23/03/2022.
//

import Foundation

//class MarvelAPI {
//    
//    static let shared = MarvelAPI(
//        baseURL: URL(string: "https://gateway.marvel.com:443")!,
//        privateKey: "a91b7da176ebca327f744add5e8208388c1b8956",
//        apiKey: "442d93a738880f5f4d6dda5e01cb531e"
//        
//    )
//
//    lazy var comicsService: MVLComicsService = {
//        return MVLComicsService(baseURL: baseURL, privateKey: privateKey, apiKey: apiKey)
//    }()
//    
//    private let baseURL: URL
//    private let privateKey: String
//    private let apiKey: String
//    
//    init(baseURL: URL, privateKey: String, apiKey: String) {
//        self.baseURL = baseURL
//        self.privateKey = privateKey
//        self.apiKey = apiKey
//    }
//    
//}
typealias ComicDataContainerCompletionResult = ((Result<ComicDataContainer, NSError>) -> Void)

class MVLComicsService {

    private let limit = 20
    
    static let shared = MVLComicsService()
    
    private let baseURL = URL(string: "https://gateway.marvel.com:443")!
    private let privateKey = "a91b7da176ebca327f744add5e8208388c1b8956"
    private let apiKey = "442d93a738880f5f4d6dda5e01cb531e"

    private var sharedSession: URLSession {
        return URLSession.shared
    }
    
    private init() {}
    
    func fetchComics(page: Int, completion: @escaping ComicDataContainerCompletionResult) {
        
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(privateKey)\(apiKey)".md5Value

        var components = URLComponents(url: baseURL.appendingPathComponent("v1/public/comics"), resolvingAgainstBaseURL: true)

        var customQueryItems = [URLQueryItem]()

        if page > 0 {
             customQueryItems.append(URLQueryItem(name: "offset", value: "\(page * limit)"))
        }

        let commonQueryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: apiKey)
        ]

        components?.queryItems = commonQueryItems + customQueryItems

        guard let url = components?.url else {
            completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "Can't build url"])))
            return
        }
        print("Comics URL:\(url)")
        let task = sharedSession.dataTask(with: url) { (data, response, error) in

            if let error = error {
                completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": error.localizedDescription])))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "Can't get data"])))
                return
            }

            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let comicData = try? decoder.decode(ComicDataWrapper.self, from: data) else {
                completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "Can't parse json"])))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(comicData.data))
            }
            
            return
        }
        
        task.resume()
    }
}
