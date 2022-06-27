//
//  EditTappedItedForm.swift
//  DaysSince
//
//  Created by Vicki Minerva on 5/27/22.
//

import SwiftUI

struct EditTappedItemForm: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var items: [DaysSinceItem]
    @Binding var completedItems: [DaysSinceItem]
    @Binding var favoriteItems: [DaysSinceItem]
    
    @Binding var tappedItem: DaysSinceItem
    @Binding var editItemSheet: Bool
    
    
    var category: CategoryDaysSinceItem = .hobbies
    
    @FocusState.Binding var nameIsFocused: Bool
    
    var body: some View {
        Form {
            nameSection
            dateSection
            newCategorySection
            reminderSection
        }
    }
    
    var nameSection: some View {
        Section {
            TextField("Name", text: $tappedItem.name)
                .focused($nameIsFocused)
        } header: {
            Text("Name")
        }
    }
    
    var reminderSection: some View {
        Section {
            Toggle("Reminders", isOn: $tappedItem.remindersEnabled.animation())
            
            // Select type of reminder
            if tappedItem.remindersEnabled {
                Picker("Remind me", selection: $tappedItem.reminder) {
                    ForEach(DSItemReminders.allCases.filter({$0 != .none}), id: \.self) {
                        Text($0.name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        } header: {
            Text("Reminders")
        }
    }
    
    
    
    var dateSection: some View {
        Section {
            DatePicker("Event Date", selection: $tappedItem.dateLastDone, in: ...Date.now, displayedComponents: .date)
                .datePickerStyle(.graphical)
        } header: {
            Text("Date")
        }
    }
    
    var newCategorySection: some View {
        Section {
            ForEach(CategoryDaysSinceItem.allCases) { category in
                Button {
                    tappedItem.category = category
                } label: {
                    HStack {
                        Image(category.emoji)
                            .resizable()
                            .frame(width: 32, height: 32)
                        
                        Text(category.name)
                        Spacer()
                        
                        if tappedItem.category == category {
                            Image(systemName: "checkmark.circle.fill")
                        }
                    }
                }
                .foregroundColor(.primary)
            }
        } header: {
            Text("Category")
        }
    }
    
    
    var categorySection: some View {
        Section {
            VStack {
                VStack {
                    Text("Select Category")
                        .accessibilityAddTraits(.isHeader)
//                        .foregroundColor(tappedItem.category.color)
                        .foregroundColor(.primary)
                    
                    CategoriesGridView(selectedCategory: $tappedItem.category.optional, addItem: false)
                }
                .padding(.vertical)
                Spacer()
                
                // Borderless Button style so that the buttons in the form casn be clicked seperately. 
                deleteItemButton
                    .buttonStyle(BorderlessButtonStyle())
                completeItemButton
                    .buttonStyle(BorderlessButtonStyle())
                favoriteItemButton
                    .buttonStyle(BorderlessButtonStyle())
            }
        }
        .padding(.vertical, 4)
        .listRowBackground(Color.clear)
    }
    
    func getItemIndex() -> Int {
        print("Looking for index of tapped item.")
        return items.firstIndex(where: {$0.id == tappedItem.id})!
    }
    
    var deleteItemButton: some View {
        Button {
            withAnimation{
                print("Clicked on Delete button, There are \(items.count) items")
                items.remove(at: getItemIndex())
                editItemSheet = false
                dismiss()
            }
        } label: {
            Text("Delete Event")
                .font(.system(.title, design: .rounded))
                .bold()
                .foregroundColor(tappedItem.category.color)
                .padding()
        }
        .padding([.top, .bottom], 10)
        .background(.white)
        .foregroundColor(tappedItem.category.color)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(tappedItem.category.color, lineWidth: 1)
        )
    }
    
    var completeItemButton: some View {
        Button {
            withAnimation{
                // Update when the item was completed.
                tappedItem.dateCompleted = Date.now
                // Add item to completed items.
                completedItems.append(tappedItem)
                // Remove from ongoing items.
                var item_index = getItemIndex()
                items.remove(at: item_index)
                // Close the sheet
                editItemSheet = false
                dismiss()
            }
        } label: {
            Text("Complete Event")
                .font(.system(.title, design: .rounded))
                .bold()
                .foregroundColor(tappedItem.category.color)
                .padding()
        }
        .padding([.top, .bottom], 10)
        .background(.white)
        .foregroundColor(tappedItem.category.color)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(tappedItem.category.color, lineWidth: 1)
        )
    }
    
    var favoriteItemButton: some View {
        Button {
            withAnimation{
                // Add item to favorite items.
                favoriteItems.append(tappedItem)
                // Remove from ongoing items.
                var item_index = getItemIndex()
                items.remove(at: item_index)
                // Close the sheet
                editItemSheet = false
                dismiss()
            }
        } label: {
            Text("Add to Favorite")
                .font(.system(.title, design: .rounded))
                .bold()
                .foregroundColor(tappedItem.category.color)
                .padding()
        }
        .padding([.top, .bottom], 10)
        .background(.white)
        .foregroundColor(tappedItem.category.color)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(tappedItem.category.color, lineWidth: 1)
        )
    }
}

//struct EditTappedItemForm_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTappedItemForm(items: .constant([]), tappedItem: DaysSinceItem.placeholderItem(), editItemSheet: true, nameIsFocused: )
//    }
//}

