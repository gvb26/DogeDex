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
    func loadMoreDogs(currentDog: Dog){
        print("Loading more dogs")
        let thresholdIndex = self.dogList.endIndex - 1
        if thresholdIndex == self.dogList.firstIndex(of: currentDog), (page + 1) <= totalPages {
            page += 1
            dogManager.getDogs(limit: 50, page: page) { data in
                DispatchQueue.main.async {
                    self.dogList.append(contentsOf: data)
                }
            }
        }
    }
    
    func getDogPage(dog: Dog) -> Int {
        return Int(Double(dog.id).rounded(to: 10.0, roundingRule: .down))
    }
    
    
    init() {
        dogManager.getDogs(limit: 1000, page: 0) { data in
            DispatchQueue.main.async {
                self.dogList = data
            }
        }
    }
    
    func getBreedDetails(_ breed: Dog) {
        self.dog = breed
    }
}
