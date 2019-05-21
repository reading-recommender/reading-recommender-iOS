//
//  Network.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badResponse
    case otherError
    case badData
    case noDecode
}

class Network {
    var questions: [Question] = []
    private let baseURL = URL(string: "https://reading-recommender.firebaseio.com/")!
    
    func getQuestions(completion: @escaping (Result<[Question], NetworkError>) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Bas response: \(response.statusCode)")
                completion(.failure(.badResponse))
                return
            }
            
            if let error = error {
                NSLog("Error: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.questions = try decoder.decode([Question].self, from: data)
                completion(.success(self.questions))
            } catch {
                NSLog("Could not decode data")
                completion(.failure(.badData))
                return
            }
        }.resume()
        
    }
    
}
