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

struct Dog: Codable, Identifiable, Equatable {
    
    static func == (lhs: Dog, rhs: Dog) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    let weight, height: unit?
    let id: Int
    let name: String
    let bredFor, breedGroupRaw: String?
    let breedGroup: BreedGroup
    let lifeSpan, temperament: String?
    let origin: String?
    let referenceImageID: String?
    let countryCode, description, history: String?

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroupRaw = "breed_group"
        case lifeSpan = "life_span"
        case temperament, origin
        case referenceImageID = "reference_image_id"
        case countryCode = "country_code"
        case description, history
    }
    
    // ✅ JSON Decoder Initializer (For API Parsing)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try? container.decode(unit.self, forKey: .height)
        weight = try? container.decode(unit.self, forKey: .weight)
        bredFor = try? container.decode(String.self, forKey: .bredFor)
        lifeSpan = try? container.decode(String.self, forKey: .lifeSpan)
        temperament = try? container.decode(String.self, forKey: .temperament)
        origin = try? container.decode(String.self, forKey: .origin)
        referenceImageID = try? container.decode(String.self, forKey: .referenceImageID)
        countryCode = try? container.decode(String.self, forKey: .countryCode)
        description = try? container.decode(String.self, forKey: .description)
        history = try? container.decode(String.self, forKey: .history)
        breedGroupRaw = try? container.decode(String?.self, forKey: .breedGroupRaw)
        breedGroup = BreedGroup(breedGroupRaw)
    }
    
    // ✅ Custom Initializer (For Testing & Manual Creation)
    init(weight: unit?, height: unit?, id: Int, name: String, bredFor: String?, breedGroupRaw: String?, lifeSpan: String?, temperament: String?, origin: String?, referenceImageID: String?, countryCode: String?, description: String?, history: String?) {
        self.weight = weight
        self.height = height
        self.id = id
        self.name = name
        self.bredFor = bredFor
        self.breedGroupRaw = breedGroupRaw
        self.breedGroup = BreedGroup(breedGroupRaw) // ✅ Assign once
        self.lifeSpan = lifeSpan
        self.temperament = temperament
        self.origin = origin
        self.referenceImageID = referenceImageID
        self.countryCode = countryCode
        self.description = description
        self.history = history
    }
    
    // ✅ Sample Dog for Testing
    static var sampleDog = Dog(
        weight: unit(imperial: "12", metric: "2"),
        height: unit(imperial: "12", metric: "2"),
        id: 1,
        name: "Corgo",
        bredFor: "Eating",
        breedGroupRaw: "",
        lifeSpan: "2 min",
        temperament: "Shiesty",
        origin: "Burma",
        referenceImageID: nil,
        countryCode: "nil",
        description: "This a sample doge",
        history: nil
    )
}


// MARK: - unit
struct unit: Codable {
    let imperial, metric: String
}

