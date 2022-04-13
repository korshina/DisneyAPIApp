//
//  DisneyCharacter.swift
//  DisneyAPIApp
//
//  Created by Anastasiia Korshina on 13.04.2022.
//

import Foundation


struct DisneyCharacter: Decodable {
    
    let films: [String]
    let shortFilms: [String]
    let tvShows: [String]
    let videoGames: [String]
    let parkAttractions: [String]
    let allies: [String]
    let enemies: [String]
    let _id: Int
    let name: String
    let imageUrl: String
    let url: String
    
    var description: String {
        """
        Films: \(films)
        TV Shows: \(tvShows)
        Video Games: \(videoGames)
        Park Attractions: \(parkAttractions)
        """
    }
    
}

struct DisneyCharactersData: Decodable {
    let data: [DisneyCharacter]
    let count: Int
    let totalPages: Int
    let previousPage: String?
    let nextPage: String?
    
}
