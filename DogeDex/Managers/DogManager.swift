//
//  DogManager.swift
//  DogeDex
//
//  Created by Gaurang Bham on 9/20/23.
//

import Foundation

class DogManager {
    func getMocksDogs() -> [Dog] {
        let dogs: [Dog] = Bundle.main.decode(file: "Dogs.json")
        
        return dogs
    }

    func getDogs(limit: Int, _ completion:@escaping ([Dog]) -> ()) {
        Bundle.main.fetchData(url: "https://api.thedogapi.com/v1/breeds?limit=\(limit)&page=0", model: [Dog].self) { data in
            completion(data)
        } failure: { error in
            print(error)
        }
    }
    
}
