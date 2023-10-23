//
//  DowntimesView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

// TODO:
// 1. Создание
// 2. Редактирование
// 3. Удаление
// 4. Обновление главного экрана после изменений
// 5. Если downtime пустышка, при включении тумблера открывать редактирование
// 6. Реализация мониторинга и блокирования в соответствии с установками
struct DowntimesView: View {
    @ObservedObject var viewModel = DowntimesViewModel()
    
    @State private var editDowntimePresenting = false
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                List(viewModel.downtimes, id: \.id) { downtime in
                    DowntimeCell(downtime: downtime, didSelect: {
                        editDowntimePresenting.toggle()
                    }, didChange: { enable in
                        // TODO
                    })
                    .sheet(isPresented: $editDowntimePresenting) {
                        EditDowntimeView(
                            isPresented: $editDowntimePresenting,
                            downtime: downtime
                        )
                    }
                }
                .listStyle(PlainListStyle())
                
                Button(action: {
                    // TODO
                }, label: {
                    Text("Downtime.Add")
                        .padding(EdgeInsets(
                            top: 12.scale,
                            leading: 32.scale,
                            bottom: 12.scale,
                            trailing: 32.scale
                        ))
                        .background(Color(Appearance.primary))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
            }
        }
    }
}
