//
//  PPPageViewItem.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/26/26.
//

import SwiftUI

struct PPPageViewItem: View {
    var pizzaPlace: PizzaPlace
    @State var positiveRating: Bool = true // used for user rating button
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            //            Color.purple
            //                .ignoresSafeArea()
            VStack {
                Text(pizzaPlace.name)
                    .font(Font.custom("Rubik-Bold", size: 25))
                    .foregroundColor(Color.ptnColorRed)
                
                HStack(alignment: .top) {
                    Text("\(pizzaPlace.street)\n\(pizzaPlace.city) \(pizzaPlace.zip)\nDistance mi away")
                        .foregroundColor(Color.ptnColorBlue)
                    
                    Spacer()
                    VStack {
                        Button(action:ratePos) {
                            Image("MCQSliceGreen")
                        }
                        Text(String(pizzaPlace.percentageLikes) + "%")
                            .foregroundColor(Color.ptnColorGreen)
                    }
                    
                    VStack {
                        Button(action:rateNeg) {
                            Image("MCQSliceRed")
                        }
                        Text(String(pizzaPlace.percentageDislikes) + "%")
                            .foregroundColor(Color.ptnColorRedRating)
                    }
                }
                .padding()
            }
            .font(Font.custom("Rubik-Light", size: 20))
        }
    }
}

func ratePos() {
    // TODO: change rating
    print("User likes this place")
}

func rateNeg() {
    // TODO: change rating
    print("User does not this place")
}

#Preview {
    PPPageViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPPage(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
        .environmentObject(MusicState())
}
