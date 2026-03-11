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
                .font(Font.custom("Rubik-Black", size: 25))
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack { // all details
                VStack { // address
                    Text(pizzaPlace.street)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(pizzaPlace.city + " " + String(pizzaPlace.zip))
                        .frame(maxWidth: .infinity, alignment: .leading)
                } // END VSTACK address
                .foregroundColor(Color.ptnColorBlue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                //                Spacer()
                VStack {
                    //                    Spacer()
                    HStack {
                        Text(String(pizzaPlace.percentageLikes) + "%")
                            .foregroundColor(Color.ptnColorGreen)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                        Text(String(pizzaPlace.percentageDislikes) + "%")
                            .foregroundColor(Color.ptnColorRedRating)
                        //                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                    }
                    Text(String(pizzaPlace.distance) + " mi")
                        .foregroundColor(Color.ptnColorBlue)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                //                Spacer()
            }
        }
        .font(Font.custom("Rubik-Light", size: 25))
        //        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
        
        
    }
}
#Preview {
    //        ListPage()
    //    .environmentObject(MusicState())
    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPPageViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
    //    PPListViewItem(pizzaPlace: pizzaPlaces[0])
        .environmentObject(MusicState())
}
