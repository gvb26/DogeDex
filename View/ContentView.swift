//
//  ContentView.swift
//  DogeDex
//
//  Created by Gaurang Bham on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = DogViewModel()
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(vm.filteredDogs) { dog in
                        NavigationLink(destination: DogDetailView(dog: dog)) {
                            DogView(dog: dog)
                                .onAppear {
                                    if dog == vm.filteredDogs.last {
                                        print("👀 Last visible dog: \(dog.name), checking for pagination")
                                        vm.loadMoreDogs(currentDog: dog)
                                    }
                                }
                        }
                    }

                    // ✅ Center ProgressView and remove it at last page
                    if vm.page + 1 < vm.totalPages {
                        HStack {
                            Spacer() // ✅ Push to center
                            ProgressView()
                                .padding(.vertical, 20)
                            Spacer() // ✅ Push to center
                        }
                    }
                }
                .animation(.easeIn(duration: 0.3), value: vm.filteredDogs.count)
                .navigationTitle("DogeDex")
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $vm.searchText)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.words)
        }
        .accentColor(.white)
        .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
