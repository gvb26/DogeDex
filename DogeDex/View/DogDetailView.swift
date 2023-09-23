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
            BreedGroup(dog.breedGroup?.lowercased()).getBreedGroupColor()
                .ignoresSafeArea()
            VStack {
                VStack {
                    VStack {
                        Text("\(dog.name.capitalized)")
                            .font(.headline).bold()
                            .foregroundColor(.white)
        //                    .padding(.top, 8)
        //                    .padding(.leading)
                            .frame(width: 400, height: 24, alignment: .center)
                        AsyncImage(url: URL(string: "https://cdn2.thedogapi.com/images/\(dog.referenceImageID ?? "rkiByec47").jpg")) { image in
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 250, height: 167, alignment: .top)
                            }
                        } placeholder: {
                            ProgressView()
                                .frame(width: 68, height: 68)
                        }
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding([.bottom, .trailing], 4)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 500, alignment: .bottom)
                    .padding(.bottom,170)

                    
                }
                .frame(width: 395, height: 300, alignment: .center)
                
                VStack {
                    VStack {
                        Text(dog.breedGroup ?? "Other")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(BreedGroup(dog.breedGroup?.lowercased()).getBreedGroupColor().opacity(0.25))
                            )
                            .frame(width: 400, height: 24, alignment: .center)
                            .padding(.top, 30)
                        HStack {
                            VStack {
                                Text("\(dog.weight?.imperial ?? "N/A")lbs")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.25))
                                    )
                                    .frame(width: 120, height: 20, alignment: .center)
                                Text("Weight")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.25))
                                    )
                                    .frame(width: 100, height: 12, alignment: .center)
                            }
                            VStack {
                                Text("\(dog.height?.imperial ?? "N/A")in")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(width: 120, height: 20, alignment: .center)
                                Text("Height")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.25))
                                    )
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
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.25))
                                    )
                                    .frame(width: 100, height: 12, alignment: .center)
                            }

                        } .padding(.vertical, 20)
                        HStack {
                            VStack {
                                Text("\(dog.bredFor ?? "N/A")")
                                    .font(.headline).minimumScaleFactor(0.7)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.25))
                                    )
                                    .frame(width: 150, height: 40, alignment: .center)
                                Text("Purpose")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.25))
                                    )
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
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.25))
                                    )
                                    .frame(width: 200, height: 12, alignment: .center)
                            }

                        }
                        .padding(.vertical, 20)
                        Text("\(dog.origin ?? "N/A")")
                            .font(.headline).minimumScaleFactor(0.7)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.25))
                            )
                            .frame(width: 150, height: 40, alignment: .center)
                        Text("Origin")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.25))
                            )
                            .frame(width: 200, height: 12, alignment: .center)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-200, alignment: .top)
                    
                    .background(.white)
                    
                }
                .cornerRadius(20)
                .padding()
            }
        }
        .background(BreedGroup(dog.breedGroup?.lowercased()).getBreedGroupColor())
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
