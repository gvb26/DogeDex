//
//  DogView.swift
//  DogeDex
//
//  Created by Gaurang Bham on 9/20/23.
//

import SwiftUI

struct DogView: View {
    @EnvironmentObject var vm: DogViewModel
    let dog: Dog
    let dimension: Double = 68
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("\(dog.name.capitalized)")
                    .font(.headline).frame(width: 140, height: 50, alignment: .leading).minimumScaleFactor(0.75)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .padding(.leading)
                HStack {
                    Text(dog.breedGroup ?? "Non-sporting")
                        .font(.subheadline).bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.25))
                        )
                        .frame(width: 100, height: 24, alignment: .center).minimumScaleFactor(0.6)
                    AsyncImage(url: URL(string: "https://cdn2.thedogapi.com/images/\(dog.referenceImageID ?? "rkiByec47").jpg")) { image in
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: dimension, height: dimension)
                        }
                    } placeholder: {
                        ProgressView()
                            .frame(width: dimension, height: dimension)
                    }
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding([.bottom, .trailing], 4)
                }
                
            }
        }
        .background(Color.green)
        .cornerRadius(12)
        .shadow(color: .green, radius: 6)
        
        
    }
}

struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        DogView(dog: Dog.sampleDog)
            .environmentObject(DogViewModel())
    }
}
