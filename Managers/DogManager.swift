//
//  DogManager.swift
//  DogeDex
//
//  Created by Gaurang Bham on 9/20/23.
//

import Foundation

class DogManager {
    func getDogs(limit: Int, page: Int, _ completion:@escaping ([Dog], Int) -> ()) {
        let urlString = "https://api.thedogapi.com/v1/breeds?limit=\(limit)&page=\(page)"
        
        Bundle.main.fetchData(url: urlString, model: [Dog].self) { data in
            if page == 0 {
                // Estimate total pages based on first request
                let estimatedTotalDogs = 172 // Based on Dog API (adjust if needed)
                let totalPages = (estimatedTotalDogs / limit) + (estimatedTotalDogs % limit > 0 ? 1 : 0)
                
                print("📡 API fetched page \(page). Estimated total pages: \(totalPages)")
                completion(data, totalPages)
            } else {
                print("📡 API fetched page \(page), received \(data.count) dogs.")
                completion(data, 0) // Don't update totalPages after page 0
            }
        } failure: { error in
            print("❌ API Error: \(error)")
            completion([], 0)
        }
    }
}
