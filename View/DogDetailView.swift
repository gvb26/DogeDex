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
        ZStack {
            VStack {
                VStack {
                    VStack {
                        Text("\(dog.name.capitalized)")
                            .font(.system(size: 40)).bold()
                            .foregroundColor(.white)
                            .padding(.top, 10)
                            .frame(width: 400, height: 24, alignment: .center)
                        Text(dog.breedGroup.string())
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(BreedGroup(dog.breedGroup.string().lowercased()).getBreedGroupColor().opacity(0.25))
                            )
                            .frame(width: 400, height: 24, alignment: .center)
                        AsyncImage(url: URL(string: "https://cdn2.thedogapi.com/images/\(dog.referenceImageID ?? "rkiByec47").jpg")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 250, height: 167, alignment: .top)
                            } else if phase.error != nil {
                                // Display a placeholder when loading failed
                                Image(uiImage: UIImage(named:"404_Dog")!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 167)
                            } else {
                                ProgressView()
                                    .frame(width: 68, height: 68)
                            }
                        }
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding([.bottom, .trailing], 4)
                        .padding(.bottom,-50)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 500, alignment: .bottom)
                    .padding(.bottom,170)

                    
                }
                .frame(width: 395, height: 300, alignment: .center)
                
                VStack {
                    VStack {
                        HStack {
                            VStack {
                                if let weight = dog.weight?.imperial {
                                    Text("\(weight)lbs")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.white.opacity(0.25))
                                        )
                                        .frame(width: 120, height: 20, alignment: .center)
                                } else {
                                    Text("N/A")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(width: 120, height: 20, alignment: .center)
                                }
                                Text("Weight")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .frame(width: 100, height: 12, alignment: .center)
                            }
                            VStack {
                                if let height = dog.height?.imperial {
                                    Text("\(height)in")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(width: 120, height: 20, alignment: .center)
                                } else {
                                    Text("N/A")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(width: 120, height: 20, alignment: .center)
                                }
                                Text("Height")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .frame(width: 100, height: 12, alignment: .center)
                            }
                            VStack {
                                Text("\(dog.lifeSpan ?? "N/A")")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(width: 120, height: 20, alignment: .center)
                                Text("LifeSpan")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .frame(width: 100, height: 12, alignment: .center)
                            }

                        } .padding(.vertical, 20)
                        HStack {
                            VStack {
                                Text("\(dog.bredFor ?? "N/A")")
                                    .font(.headline).minimumScaleFactor(0.7)
                                    .foregroundColor(.black)
                                    .frame(width: 150, height: 40, alignment: .center)
                                Text("Purpose")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .frame(width: 200, height: 12, alignment: .center)
                            }
                            VStack {
                                Text("\(dog.temperament ?? "N/A")")
                                    .font(.headline).minimumScaleFactor(0.7)
                                    .foregroundColor(.black)
                                    .frame(width: 150, height: 40, alignment: .center)
                                Text("Temperament")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .frame(width: 200, height: 12, alignment: .center)
                            }

                        }
                        .padding(.vertical, 20)
                        Text("\(dog.origin ?? "N/A")")
                            .font(.headline).minimumScaleFactor(0.7)
                            .foregroundColor(.black)
                            .frame(width: 150, height: 40, alignment: .center)
                        Text("Origin")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .frame(width: 200, height: 12, alignment: .center)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-200, alignment: .top)
                    
                    .background(.white)
                    
                }
                .cornerRadius(25)
                .padding(.vertical, 90)
            }
        }
        .background(BreedGroup(dog.breedGroup.string().lowercased()).getBreedGroupColor().gradient)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .top)
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
