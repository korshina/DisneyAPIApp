//
//  NetworkManager.swift
//  DisneyAPIApp
//
//  Created by Anastasiia Korshina on 13.04.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

enum Link: String {
    case mainLink = "https://api.disneyapi.dev/characters?page=1"
}

class NetworkManager {
    
    static let shared = NetworkManager()
      
    init() {}
    
    func fetchDisneyData(comletion: @escaping (Result<DisneyCharactersData, NetworkError>) -> Void) {
        guard let url = URL(string: Link.mainLink.rawValue) else {
            print("Invalid URL")
            comletion(.failure(.invalidUrl))
            return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                comletion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return }
            do {
                let disneyCharactersData = try JSONDecoder().decode(DisneyCharactersData.self, from: data)
                DispatchQueue.main.async {
                    comletion(.success(disneyCharactersData))
                }
                
            } catch let error {
                comletion(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func fetchImageData(string: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: string) else {
            print("Invalid URL")
            completion(.failure(.invalidUrl))
            return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        dataTask.resume()
               
    }
  
}
