//
//  DogViewModel.swift
//  DogeDex
//
//  Created by Gaurang Bham on 9/20/23.
//

import Foundation
import SwiftUI

final class DogViewModel: ObservableObject {
    private let dogManager = DogManager()
    
    
    @Published var dogList = [Dog]()
    @Published var dog: Dog?
    @Published var searchText = ""

    var filteredDogs: [Dog] {
        return searchText == "" ? dogList : dogList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var totalPages = 0
    var page : Int = 0
    
    //MARK: - PAGINATION
    func loadMoreDogs(currentDog: Dog) {
        guard (page + 1) < totalPages else {
            print("🚨 Reached last page (\(totalPages)), stopping pagination")
            return
        }

        if let lastDog = dogList.last, lastDog.id == currentDog.id {
            page += 1  // ✅ Increment before calling API
            
            print("📢 Fetching page \(page) / \(totalPages)")

            dogManager.getDogs(limit: 20, page: page) { newDogs, _ in
                DispatchQueue.main.async {
                    let uniqueDogs = newDogs.filter { !self.dogList.contains($0) } // Remove duplicates
                    self.dogList.append(contentsOf: uniqueDogs)
                    
                    print("✅ Added \(uniqueDogs.count) new dogs, total count: \(self.dogList.count)")
                }
            }
        }
    }
    
    func getDogPage(dog: Dog) -> Int {
        return Int(Double(dog.id).rounded(to: 10.0, roundingRule: .down))
    }
    
    func hasReachedEnd(of dog: Dog) -> Bool {
        return filteredDogs.last?.id == dog.id
        
    }
    
    init() {
        print("🔄 Initializing DogViewModel...")

        dogManager.getDogs(limit: 20, page: 0) { data, calculatedTotalPages in
            DispatchQueue.main.async {
                self.dogList = data
                self.totalPages = calculatedTotalPages // ✅ Set dynamically
                print("✅ Initial fetch complete. Total pages: \(self.totalPages), Dogs loaded: \(self.dogList.count)")
            }
        }
    }
    
    func getBreedDetails(_ breed: Dog) {
        self.dog = breed
    }
}
