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
    var token: Token?
    
    private let baseURL = URL(string: "https://reader-recommend.herokuapp.com/")!
    
    
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
    
    func getRecommendation(answers: Answer, completion: @escaping (Result<Book, NetworkError>) -> Void){
        
        let url = baseURL.appendingPathComponent("recommend")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        do {
            request.httpBody = try encoder.encode(answers)
        } catch {
            NSLog("Could not encode answers")
            completion(.failure(.otherError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error getting recommendation: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Incorrect response from server: \(response.statusCode)")
                completion(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                NSLog("Bad data")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let book: Book = try decoder.decode(Book.self, from: data)
                completion(.success(book))
                return
            } catch {
                NSLog("Could not decode data")
                completion(.failure(.noDecode))
                return
            }
            
        }.resume()
    }
    
}
