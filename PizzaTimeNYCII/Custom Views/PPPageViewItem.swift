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
                    .font(.largeTitle)
                    .foregroundColor(Color.ptnColorRed)
                HStack(alignment: .top) {
                    Text("\(pizzaPlace.address)\nNY NY ZIP\nDistance mi away")
                        .foregroundColor(Color.ptnColorBlue)
                    Spacer()
                    VStack {
                        Button(action:ratePos) {
                            Image("MCQSliceGreen")
                        }
                        Text("100%")
                            .foregroundColor(Color.ptnColorGreen)

                    }
                    VStack {
                        Button(action:rateNeg) {
                            Image("MCQSliceRed")
                        }
                        Text("0%")
                            .foregroundColor(Color.ptnColorRedRating)

                    }
                }
                .padding()
//                .font(Font.system(size: 18, weight: .bold, design: .default))
                //                Spacer()
            }
        }
    }
}

func ratePos() {
    print("User likes this place")
}

func rateNeg() {
    print("User does not this place")
}

#Preview {
    PPPageViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
        .environmentObject(MusicState())
}
