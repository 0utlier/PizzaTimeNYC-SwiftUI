//
//  PizzaPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 3/5/26.
//

import SwiftUI

enum PizzaPage {
//    case home
    case list
    case map
    case closest
    case feedback
    case add
    case about
}

extension PizzaPage {
    
    var audioFileName: String {
        switch self {
//        case .home:
//            return "excellent"
        case .list:
            return "adventureTimePizza"
        case .map:
            return "rickBestPizza"
        case .closest:
            return "krustyKrabPizza"
        case .feedback:
            return "annoyedRick"
        case .add:
            return "excellent"
        case .about:
            return "ATHFPizzaTime"
        }
    }
    
}

extension PizzaPage {
    
    var title: String {
        switch self {
//        case .home: return "Home"
        case .list: return "Pizza List"
        case .map: return "Pizza Map"
        case .closest: return "Closest Pizza"
        case .feedback: return "Feedback"
        case .add: return "Add Pizza"
        case .about: return "About"
        }
    }
    
}
//NavigationLink(destination: ListPage(), tag: .list, selection: $nav.activePage) {EmptyView()}

//extension PizzaPage {
//    var navigationL: NavigationLink(){
//        switch self {
//        case .home: return NavigationLink(destination: ListPage(), tag: .list, selection: $nav.activePage) {EmptyView()}
//        case .list: return NavigationLink(destination: ListPage(), tag: .list, selection: $nav.activePage) {EmptyView()}
//        case .map: return NavigationLink(destination: ListPage(), tag: .list, selection: $nav.activePage) {EmptyView()}
//        case .closest: return NavigationLink(destination: ListPage(), tag: .list, selection: $nav.activePage) {EmptyView()}
//        case .feedback: return NavigationLink(destination: ListPage(), tag: .list, selection: $nav.activePage) {EmptyView()}
//        case .add: return NavigationLink(destination: ListPage(), tag: .list, selection: $nav.activePage) {EmptyView()}
//        case .about: return NavigationLink(destination: ListPage(), tag: .list, selection: $nav.activePage) {EmptyView()}
//        }
//    }
//}

extension PizzaPage {
    
    @ViewBuilder
    var destinationView: some View {
        switch self {
//        case .home:
//            ContentView()
        case .list:
            ListPage()
        case .map:
            MapPage()
        case .closest:
            MapPage() // TODO: based on current location. immediate directions
        case .about:
            AboutPage()
        case .add:
            AddPage()
        case .feedback:
            FeedbackPage()
        }
    }
}

