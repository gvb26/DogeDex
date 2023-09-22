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
            ZStack {
                VStack(alignment: .center) {
                    HStack {
                        AsyncImage(url: URL(string: "https://cdn2.thedogapi.com/images/\(dog.referenceImageID ?? "rkiByec47").jpg")) { image in
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 250, height: 167)
                            }
                        } placeholder: {
                            ProgressView()
                                .frame(width: 68, height: 68)
                        }
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding([.bottom, .trailing], 4)
                    }
                    
                }
            }
            .frame(width: 395, height: 300, alignment: .center)
            .background(BreedGroup(dog.breedGroup?.lowercased()).getBreedGroupColor())
            .cornerRadius(12)
            .shadow(color: BreedGroup(dog.breedGroup?.lowercased()).getBreedGroupColor(), radius: 6)
            VStack(spacing: 10) {
                Text("\(dog.name.capitalized)")
                    .font(.headline)//.frame(width: 140, height: 50, alignment: .leading).minimumScaleFactor(0.75)
                    .foregroundColor(.black)
//                    .padding(.top, 8)
//                    .padding(.leading)
                    .frame(width: 400, height: 24, alignment: .center)
                Text(dog.breedGroup ?? "Other")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.25))
                    )
                    .frame(width: 400, height: 24, alignment: .center)
                Text(dog.weight?.imperial ?? "weight")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.25))
                    )
                    .frame(width: 400, height: 24, alignment: .center)
                Text(dog.height?.imperial ?? "height")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.25))
                    )
                    .frame(width: 400, height: 24, alignment: .center)
                Text(dog.temperament ?? "temperament")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.25))
                    )
                    .frame(width: 400, height: 24, alignment: .center)
                Text(dog.bredFor ?? "bredFor")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.25))
                    )
                    .frame(width: 400, height: 24, alignment: .center)
                Text(dog.lifeSpan ?? "lifeSpan")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.25))
                    )
                    .frame(width: 400, height: 24, alignment: .center)
                Text(dog.origin ?? "origin")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.25))
                    )
                    .frame(width: 400, height: 24, alignment: .center)
//                Text("**ID**: \(vm.dog?.id ?? 0)")
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
