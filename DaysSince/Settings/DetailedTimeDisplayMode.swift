//
//  DetailedTimeDisplayMode.swift
//  DaysSince
//
//  Created by Vicki Minerva on 7/26/22.
//

import SwiftUI

struct DetailedTimeDisplayModeCell: View {
    
    @Binding var isDaysDisplayModeDetailed: Bool
    
    var body: some View {
        
        Section {
            HStack {
                LinearGradient(colors: [Color.workColor, Color.workColor.lighter()], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 30, height: 30)
                    .cornerRadius(8)
                    .overlay(
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.white)
                    )
                    .padding(.leading, -10)
                
                // Current wording is poor.
                Text("Detailed Time Display Mode")
                    .font(.system(.body, design: .rounded))
                
                Spacer()
                toggle
            }
        } footer: {
            Text("Display the number of years, months, and days since an event")
                .font(Font.system(.body, design: .rounded))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading, -8)
        }
    }
    
    var toggle: some View {
        Toggle("Detailed Time Display Mode", isOn: $isDaysDisplayModeDetailed)
            .tint(Color.workColor)
            .labelsHidden()
    }
}

struct DetailedTimeDisplayMode_Previews: PreviewProvider {
    static var previews: some View {
        DetailedTimeDisplayModeCell(isDaysDisplayModeDetailed: .constant(false))
    }
}
