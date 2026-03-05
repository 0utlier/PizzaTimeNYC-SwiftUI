//
//  PPListViewItem.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/25/26.
//

import SwiftUI

struct PPListViewItem: View {
    var pizzaPlace: PizzaPlace
    
    var body: some View {
        //        ZStack(alignment: .topTrailing) {
        //            Color.purple
        //                .ignoresSafeArea()
        VStack {
            Text(pizzaPlace.name)
                .fontWeight(.bold)
                .foregroundColor(Color.ptnColorRed)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                VStack {
                    Text(pizzaPlace.address)
                        .foregroundColor(Color.ptnColorBlue)
                }
                //                .font(Font.system(size: 18, weight: .bold, design: .default))
                Spacer()
                VStack {
                    //                    Spacer()
                    HStack {
                        Text("100%")
                            .foregroundColor(Color.ptnColorGreen)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                        Text("0%")
                            .foregroundColor(Color.ptnColorRedRating)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                    }
                    Text("Distance")
                        .foregroundColor(Color.ptnColorBlue)
                }
                //                Spacer()
            }
        }
        .font(Font.custom("Rubik-Black", size: 25))
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
        
        
    }
}
#Preview {
    //    ListPage()
    //    .environmentObject(MusicState())
    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPPageViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
        .environmentObject(MusicState())
}
