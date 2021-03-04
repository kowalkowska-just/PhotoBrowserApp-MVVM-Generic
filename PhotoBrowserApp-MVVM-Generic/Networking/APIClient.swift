//
//  APIClient.swift
//  PhotoBrowserApp-MVVM-Generic
//
//  Created by Justyna Kowalkowska on 04/03/2021.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(
        with request: URLRequest,
        decode: @escaping(Decodable) -> T?,
        completion: @escaping(Result<T, APIError>) -> Void
    )
}

extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, complition: @escaping JSONTaskCompletionHandler) -> URLSessionTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpRespone = response as? HTTPURLResponse else {
                complition(nil, .requestFailed)
                return
            }
            
            if httpRespone.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        complition(genericModel, nil)
                    } catch {
                        complition(nil, .jsonConversionFailed)
                    }
                } else {
                    complition(nil, .invalidData)
                }
            } else {
                complition(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(
        with request: URLRequest,
        decode: @escaping(Decodable) -> T?,
        completion: @escaping(Result<T, APIError>) -> Void
    ) {
        let task = decodingTask(with: request, decodingType: T.self) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
            }
                
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailed))
                }
            }
        }
        
        task.resume()
    }
}
