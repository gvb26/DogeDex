//
//  DogModel.swift
//  DogeDex
//
//  Created by Gaurang Bham on 9/19/23.
//

import Foundation

struct DogList: Codable {
    let results: [Dog]
}
//
//struct Dog: Codable, Identifiable, Equatable {
//    let id = UUID()
//    let name: String
//    let url: String
//
//    static var sampleDog = Dog(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
//}
//
//struct DetailDog: Codable {
//    let id: String
//    let height: String
//    let weight: String
//}
//
struct Dog: Codable, Identifiable, Equatable {
    
    static func == (lhs: Dog, rhs: Dog) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    
    let weight, height: unit?
    let id: Int
    let name: String
    let bredFor, breedGroup: String?
    let lifeSpan, temperament: String?
    let origin: String?
    let referenceImageID: String?
    let countryCode, description, history: String?

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament, origin
        case referenceImageID = "reference_image_id"
        case countryCode = "country_code"
        case description, history
    }
    
    static var sampleDog = Dog(weight: nil, height: nil, id: 1, name: "Corgo", bredFor: nil, breedGroup: nil, lifeSpan: nil, temperament: nil, origin: nil, referenceImageID: nil, countryCode: nil, description: nil, history: nil)
}

// MARK: - unit
struct unit: Codable {
    let imperial, metric: String
}

