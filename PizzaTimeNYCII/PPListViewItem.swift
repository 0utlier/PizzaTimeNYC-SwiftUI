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
        ZStack(alignment: .topTrailing) {
//            Color.purple
//                .ignoresSafeArea()
            
            HStack {
                VStack {
                    Text(pizzaPlace.name)
                    Text(pizzaPlace.address)
                }
                .font(Font.system(size: 18, weight: .bold, design: .default))
                Spacer()
                VStack {
                    Text("Distance")
                    Text("Rating")
                }
//                Spacer()
            }
        }
    }
}
#Preview {
    PPListViewItem(pizzaPlace: pizzaPlaces[0])
//    PPListViewItem(pizzaPlace: pizzaPlaces[0])
//    PPListViewItem(pizzaPlace: pizzaPlaces[0])
//    PPListViewItem(pizzaPlace: pizzaPlaces[0])
        .environmentObject(MusicState())
}
