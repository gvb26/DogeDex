//
//  DogDetailView.swift
//  DogeDex
//
//  Created by Gaurang Bham on 9/20/23.
//

import Foundation
import SwiftUI

struct DogDetailView: View {
    @EnvironmentObject var vm: DogViewModel
    let dog: Dog
    
    var body: some View {
        VStack {
            DogView(dog: dog)
            VStack(spacing: 10) {
                Text("**ID**: \(vm.dog?.id ?? 0)")
                Text("**NAME**: \(vm.dog?.name ?? "N/A")")
            }
            .padding()
        }
        .onAppear{
            vm.getBreedDetails(dog)
        }
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(dog: Dog.sampleDog)
            .environmentObject(DogViewModel())
    }
}
