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
    case post = "POST"
}

enum NetworkError: Error {
    case badResponse
    case otherError
    case badData
    case noDecode
}

class Network {
    var questions: [Question] = []
    var token: Token?
    
    private let questionBaseURL = URL(string: "https://reading-recommender.firebaseio.com/")!
    private let baseURL = URL(string: "https://reading-recommender.herokuapp.com/")!
    
    func getQuestions(completion: @escaping (Result<Question, NetworkError>) -> Void) {
        let url = questionBaseURL.appendingPathExtension("json")
        
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
            
//            let question = try? newJSONDecoder().decode(Question.self, from: jsonData)

            
            let decoder = JSONDecoder()
            do {
                let questions = try decoder.decode(Question.self, from: data)
                completion(.success(questions))
            } catch {
                NSLog("Could not decode data")
                completion(.failure(.badData))
                return
            }
        }.resume()
        
    }
    
    func signUp(for user: User, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent("api/signup")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(user)
        } catch{
            NSLog("Error encoding user: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let respons = response as? HTTPURLResponse, respons.statusCode != 201 {
                completion(NSError(domain: "", code: respons.statusCode, userInfo:nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
                
        }.resume()
    }
    
    func Login(for user: User, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent("api/login")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(user)
        } catch{
            NSLog("Error encoding user: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let respons = response as? HTTPURLResponse, respons.statusCode != 201 {
                completion(NSError(domain: "", code: respons.statusCode, userInfo:nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.token = try decoder.decode(Token.self, from: data)
            } catch {
                print("Error decoding token object: \(error)")
                completion(error)
                return
            }
            
            
            print(user)
            completion(nil)
            
            }.resume()
    }
    
}
