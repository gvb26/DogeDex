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
        return searchText == "" ? dogList : dogList.filter {
            $0.name.contains(searchText.lowercased())
            
        }
    }
    
    init() {
        dogManager.getDogs(limit: 1000) { data in
            DispatchQueue.main.async {
                self.dogList = data
            }
        }
    }
    
    func getBreedDetails(_ breed: Dog) {
        self.dog = breed
    }
}
