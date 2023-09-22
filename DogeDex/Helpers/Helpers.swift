//
//  Helpers.swift
//  DogeDex
//
//  Created by Gaurang Bham on 9/19/23.
//

import Foundation
import SwiftUI


extension Bundle {
    func decode<T:Decodable>(file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load data from file")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Error")
        }
        
        return loadedData
    }
    
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
            guard let url = URL(string: url) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    // If there is an error, return the error.
                    if let error = error { failure(error) }
                    return }
                
                do {
                    let serverData = try JSONDecoder().decode(T.self, from: data)
                    // Return the data successfully from the server
                    completion((serverData))
                } catch {
                    // If there is an error, return the error.
                    failure(error)
                }
            }.resume()
    }
}

extension FloatingPoint {
    func rounded(to value: Self, roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
       (self / value).rounded(roundingRule) * value
    }
}

enum BreedGroup: String {
    case herding = "herding"
    case terrier = "terrier"
    case working = "working"
    case nonSporting = "non-sporting"
    case hound = "hound"
    case sporting = "sporting"
    case toy = "toy"
    case mixed = "mixed"
    case other = "other"
    
    init(_ group: String?) {
        switch group {
        case "herding":
            self = .herding
        case "terrier":
            self = .terrier
        case "working":
            self = .working
        case "non-sporting":
            self = .nonSporting
        case "hound":
            self = .hound
        case "sporting":
            self = .sporting
        case "toy":
            self = .toy
        case "mixed":
            self = .mixed
        default:
            self = .other
        }
    }
    
    func getBreedGroupColor() -> Color {
        switch self {
        case .herding:
            return Color.orange
        case .terrier:
            return Color.red
        case .working:
            return Color.green
        case .nonSporting:
            return Color.purple
        case .hound:
            return Color.brown
        case .sporting:
            return Color.blue
        case .toy:
            return Color.pink
        case .mixed:
            return Color.mint
        default:
            return Color.yellow
        }
    }
}

struct BreedGroupColor {
    static let herding = Color.orange
    static let terrier = Color.red
    static let working = Color.black
    static let nonSporting = Color.purple
    static let hound = Color.brown
    static let sporting = Color.blue
    static let toy = Color.pink
    static let mixed = Color.mint
    static let other = Color.gray
}
