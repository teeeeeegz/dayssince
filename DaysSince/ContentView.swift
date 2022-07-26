//
//  ContentView.swift
//  DaysSince
//
//  Created by Vicki Minerva on 3/28/22.
//

import SwiftUI


struct ContentView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    @AppStorage("items", store: UserDefaults(suiteName: "group.goodsnooze.dayssince")) var items: [DaysSinceItem] = []
    @AppStorage("completedItems") var completedItems = [DaysSinceItem]()
    @AppStorage("favoriteItems") var favoriteItems = [DaysSinceItem]()
    
    var body: some View {
        if hasSeenOnboarding {
            MainScreen(items: $items, completedItems: $completedItems, favoriteItems: $favoriteItems)
        } else {
            OnboardingScreen(hasSeenOnboarding: $hasSeenOnboarding, items: $items)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
