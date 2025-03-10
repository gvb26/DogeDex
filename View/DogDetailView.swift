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
    @State private var selectedTab: String = "Stats"

    var body: some View {
        ZStack {
//            BreedGroup(dog.breedGroup.string().lowercased()).getBreedGroupColor().gradient
//                .ignoresSafeArea()

            GeometryReader { geometry in
                VStack(spacing: 20) {
                    VStack(spacing: 20) {
                        Spacer(minLength: 40) // ✅ Push content below notch

                        // 🏆 Dog Name & Breed Tag
                        VStack(spacing: 8) {
                            Text("\(dog.name.capitalized)")
                                .font(.system(size: 40)).bold()
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)

                            Text(dog.breedGroup.string())
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(BreedGroup(dog.breedGroup.string().lowercased()).getBreedGroupColor().opacity(0.25))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.white.opacity(0.25))
                                        )
                                )
                        }

                        // 🖼️ Dog Image
                        AsyncImage(url: URL(string: "https://cdn2.thedogapi.com/images/\(dog.referenceImageID ?? "rkiByec47").jpg")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                            } else if phase.error != nil {
                                Image(uiImage: UIImage(named: "404_Dog")!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 167)
                            } else {
                                ProgressView()
                                    .frame(width: 68, height: 68)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 20)

                        // 📌 Toggle Section: Stats / Details
                        Picker("View Mode", selection: $selectedTab) {
                            Text("Stats").tag("Stats")
                            Text("Details").tag("Details")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 20)
                    }
                    .frame(maxWidth: .infinity)

                    // 📏 Stats/Details Section (Now Fully Centered)
                    VStack {
                        VStack(spacing: 30) {
                            if selectedTab == "Stats" {
                                StatsView(dog: dog)
                            } else {
                                DetailsView(dog: dog)
                            }
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // ✅ Keeps content at the top
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.45) // ✅ Stretches properly
                    .background(.white)
                    .cornerRadius(25)
                }
            }
        }
        .background(BreedGroup(dog.breedGroup.string().lowercased()).getBreedGroupColor().gradient)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
        .onAppear {
            vm.getBreedDetails(dog)
        }
    }
}

// 🔹 Stats Section: Height, Weight, Lifespan, Origin
struct StatsView: View {
    let dog: Dog
    var body: some View {
        VStack(spacing: 40) {
            StatView(title: "Weight", value: (dog.weight?.imperial ?? "N/A") + "lbs")
            StatView(title: "Height", value: (dog.height?.imperial ?? "N/A") + "in")
            StatView(title: "LifeSpan", value: dog.lifeSpan ?? "N/A")
            StatView(title: "Origin", value: dog.origin ?? "N/A")
        }
        .frame(maxWidth: .infinity, alignment: .leading) // ✅ Keeps content at the top
    }
}

// 🔹 Details Section: Purpose, Temperament
struct DetailsView: View {
    let dog: Dog
    var body: some View {
        VStack(spacing: 40) {
            StatView(title: "Purpose", value: dog.bredFor ?? "N/A", wide: true)
            StatView(title: "Temperament", value: dog.temperament ?? "N/A", wide: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading) // ✅ Keeps content at the top
    }
}

// 🔹 Reusable Stat View
struct StatView: View {
    let title: String
    let value: String
    var wide: Bool = false
    
    var body: some View {
        HStack(spacing: 5) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
                .frame(width: 100)
            
            Text(value)
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: 200)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(dog: Dog.sampleDog)
            .environmentObject(DogViewModel())
    }
}



/*
 .background(BreedGroup(dog.breedGroup.string().lowercased()).getBreedGroupColor().gradient)
 .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
 */
