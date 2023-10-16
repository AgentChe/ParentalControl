//
//  TimePickerView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 11.10.2023.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    
    var body: some View {
        HStack {
            Picker(selection: $selectedHour, label: Text("")) {
                ForEach(0..<24, id: \.self) { hour in
                    Text(formatted(hour))
                        .foregroundColor(Color(Appearance.black))
                        .font(Font(Fonts.Satoshi.bold(size: 24.scale)))
                }
            }
            .padding(.trailing, 8.scale)
            .pickerStyle(WheelPickerStyle())
            .clipped()
            
            Picker(selection: $selectedMinute, label: Text("")) {
                ForEach(0..<60) { minute in
                    Text(formatted(minute))
                        .foregroundColor(Color(Appearance.black))
                        .font(Font(Fonts.Satoshi.bold(size: 24.scale)))
                }
            }
            .padding(.leading, 8.scale)
            .pickerStyle(WheelPickerStyle())
            .clipped()
        }
    }
}

// MARK: Private
private extension TimePickerView {
    func formatted(_ value: Int) -> String {
        if value < 10 {
            return "0\(value)"
        }
        
        return "\(value)"
    }
}
