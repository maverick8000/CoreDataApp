//
//  NetworkManager.swift
//  CoreDataApp7
//
//  Created by Raul Barranco on 7/25/22.
//

import Foundation

protocol NetworkService {
    
    func getModel<T: Decodable>(url: URL?, completion: @escaping(Result<T, NetworkError>) -> Void)
    func getRawData(url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void)
    
}

class NetworkManager {
    
    let session: URLSession
    let decoder: JSONDecoder = JSONDecoder()
    
    init(session: URLSession = URLSession.shared) {
        
        self.session = session
        
    }
    
}

extension NetworkManager: NetworkService {
    
    func getModel<T>(url: URL?, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        guard let url = url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.other(error)))
                return
            }
            
            if let hResponse = response as? HTTPURLResponse, !(200..<300).contains(hResponse.statusCode) {
                completion(.failure(NetworkError.serverResponse(hResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            do {
                let model = try self.decoder.decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(NetworkError.decodeError(error)))
            }
            
        }.resume()
        
    }
    
    func getRawData(url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard let url = url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.other(error)))
                return
            }
            
            if let hResponse = response as? HTTPURLResponse, !(200..<300).contains(hResponse.statusCode) {
                completion(.failure(NetworkError.serverResponse(hResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            completion(.success(data))
            
        }.resume()
        
    }
    
    
    
    
}
