//
//  DateSheet.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 26.10.2023.
//

import SwiftUI

struct DateSheet: View {
    let title: String
    let subTitle: String
    @Binding var time: Date?
    @Binding var isPresenting: Bool
    
    @State private var hours: Int
    @State private var minutes: Int
    
    init(
        title: String,
        subTitle: String,
        time: Binding<Date?>,
        isPresenting: Binding<Bool>
    ) {
        self.title = title
        self.subTitle = subTitle
        self._time = time
        self._isPresenting = isPresenting
        
        if let date = time.wrappedValue {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute], from: date)
            self._hours = State(initialValue: components.hour ?? 10)
            self._minutes = State(initialValue: components.minute ?? 0)
        } else {
            self._hours = State(initialValue: 10)
            self._minutes = State(initialValue: 0)
        }
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                Text(title)
                    .foregroundColor(Color(Appearance.black))
                    .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                    .padding(EdgeInsets(
                        top: 32.scale,
                        leading: 32.scale,
                        bottom: 0,
                        trailing: 32.scale
                    ))
                
                Text(subTitle)
                    .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                    .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                    .padding(EdgeInsets(
                        top: 0,
                        leading: 48.scale,
                        bottom: 12.scale,
                        trailing: 48.scale
                    ))
                
                TimePickerView(
                    selectedHour: $hours,
                    selectedMinute: $minutes
                )
                .padding(.bottom, 16.scale)
                
                Button(action: {
                    save()
                    isPresenting = false
                }, label: {
                    Text("Downtime.Save".localized)
                        .padding(.top, 12.scale)
                        .padding(.bottom, 12.scale)
                        .frame(width: 210.scale)
                        .background(Color(Appearance.primary))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
            }
        }
    }
}

// MARK: Private
private extension DateSheet {
    func save() {
        var components = DateComponents()
        components.hour = hours
        components.minute = minutes
        guard let date = Calendar.current.date(from: components) else {
            return
        }
        
        time = date
    }
}
