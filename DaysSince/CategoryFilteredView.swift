//
//  CategoryView.swift
//  DaysSince
//
//  Created by Vicki Minerva on 4/8/22.
//

import SwiftUI

struct CategoryFilteredView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    
    var category: CategoryDaysSinceItem
    
    @State var showAddItemSheet: Bool
    @State var editItemSheet: Bool
    @State var tappedItem = DaysSinceItem.placeholderItem()
    
    @Binding var items: [DaysSinceItem]
    @Binding var completedItems: [DaysSinceItem]
    @Binding var favoriteItems: [DaysSinceItem]
    
    @Binding var isDaysDisplayModeDetailed: Bool
    
    var body: some View {
        
        ZStack {
            background
            
            ScrollView {
                
                NormalItemsList(
                    items: $items,
                    editItemSheet: $editItemSheet,
                    tappedItem: $tappedItem,
                    isDaysDisplayModeDetailed: $isDaysDisplayModeDetailed,
                    isCategoryView: true,
                    category: category)
                
                
                CompletedItemsList(completedItems: $completedItems, isCategoryView: true, category: category)
                
                // Add some space after the items for the button.
                Color(.clear)
                    .frame(height: 100)
            }
            
            Spacer()
            addItemButton
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showAddItemSheet) {
            AddItemSheet(selectedCategory: category, remindersEnabled: false, items: $items)
        }
        .sheet(isPresented: $editItemSheet) {
            EditTappedItemSheet(items: $items, completedItems: $completedItems, favoriteItems: $favoriteItems, tappedItem: $tappedItem, editItemSheet: $editItemSheet)
        }
    }
    
    @ViewBuilder
    var background: some View {
        if colorScheme == .dark {
            LinearGradient(
                gradient: .init(colors: [category.color.opacity(0.4).darker(by: 0.4), category.color.opacity(0.2).darker(by: 0.4)]),
                startPoint: .init(x: 1, y: 0),
                endPoint: .init(x: 0.0001, y: 0))
            .ignoresSafeArea()
            
        } else {
            LinearGradient(
                gradient: .init(colors: [category.color.opacity(0.1), category.color.opacity(0.2)]),
                startPoint: .init(x: 1, y: 0),
                endPoint: .init(x: 0.0001, y: 0))
            .ignoresSafeArea()
        }
    }
    
    var addItemButton: some View {
        VStack {
            Spacer()
            Button {
                showAddItemSheet = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.white)
                }
                .padding()
                .background(LinearGradient(
                    gradient: .init(colors: [category.color.opacity(0.8), category.color]),
                    startPoint: .init(x: 0.0, y: 0.5),
                    endPoint: .init(x: 0, y: 1)))
                .clipShape(Capsule())
                .shadow(color: items.filter{ $0.category.color == category.color}.count < 5 ? category.color : .white, radius: 10, x: 0, y: 5)
            }
        }
    }
}


struct CategoryFilteredView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFilteredView(category: .work, showAddItemSheet: false, editItemSheet: false, tappedItem: DaysSinceItem.placeholderItem(), items: .constant([DaysSinceItem.placeholderItem()]), completedItems: .constant([]), favoriteItems: .constant([]), isDaysDisplayModeDetailed: .constant(false))
            .preferredColorScheme(.dark)
    }
}

