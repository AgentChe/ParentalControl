//
//  WebDomainView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 06.10.2023.
//

import SwiftUI
import ManagedSettings

struct WebDomainView: View {
    @State var item: WebHistoryItem
    
    @State private var sheetPresenting = false
    
    private let store = ManagedSettingsStore.webHistory
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(Color(Appearance.background2))
            
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(Color(Appearance.white))
                .padding(EdgeInsets(
                    top: 3.scale,
                    leading: 3.scale,
                    bottom: 6.scale,
                    trailing: 3.scale
                ))
            
            HStack {
                VStack {
                    HStack {
                        Image(item.blocked ? "WebHistory.Blocked" : "WebHistory.Enabled")
                            .resizable()
                            .frame(width: 24.scale, height: 24.scale, alignment: .center)
                        
                        Text(item.domain.domain ?? "")
                            .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                            .foregroundColor(Color(item.blocked ? Appearance.textRed : Appearance.textBlue))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(time())
                            .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                            .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    sheetPresenting.toggle()
                }, label: {
                    Image("WebHistory.Menu")
                        .resizable()
                        .frame(width: 24.scale, height: 24.scale, alignment: .center)
                })
                .sheet(isPresented: $sheetPresenting) {
                    ZStack {
                        Color(Appearance.background)
                        VStack {
                            Text(item.blocked ? "WebHistory.BlockSheet.Title.Unblock".localized : "WebHistory.BlockSheet.Title.Block".localized)
                                .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                                .foregroundColor(Color(Appearance.black))
                                .padding(.top, 32.scale)
                            
                            Text(item.blocked ? "WebHistory.BlockSheet.SubTitle.Unblock".localized : "WebHistory.BlockSheet.SubTitle.Block".localized)
                                .padding(EdgeInsets(top: 0, leading: 48.scale, bottom: 28.scale, trailing: 48.scale))
                                .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                                .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                guard let token = item.domain.token else {
                                    return
                                }
                                
                                var domains = store.shield.webDomains ?? []
                                
                                if item.blocked {
                                    domains.remove(token)
                                } else {
                                    domains.insert(token)
                                }
                                
                                store.shield.webDomains = domains
                                item.blocked.toggle()
                                
                                sheetPresenting.toggle()
                            }, label: {
                                ZStack {
                                    Color(Appearance.primary)
                                    
                                    Text(item.blocked ? "WebHistory.BlockSheet.Unblock".localized : "WebHistory.BlockSheet.Block".localized)
                                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                                        .foregroundColor(Color(Appearance.black))
                                }
                                .frame(width: 210.scale, height: 47.scale, alignment: .center)
                                .cornerRadius(20.scale)
                            })
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: {
                                sheetPresenting.toggle()
                            }, label: {
                                ZStack {
                                    Color(Appearance.background2)
                                    
                                    Text("Cancel".localized)
                                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                                        .foregroundColor(Color(Appearance.black))
                                }
                                .frame(width: 210.scale, height: 47.scale, alignment: .center)
                                .cornerRadius(20.scale)
                            })
                            .buttonStyle(PlainButtonStyle())
                            
                            Spacer()
                        }
                    }
                    .presentationDetents([.height(292.scale)])
                }
            }
            .padding(16.scale)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(
            top: 8.scale,
            leading: 8.scale,
            bottom: 8.scale,
            trailing: 8.scale
        ))
    }
}

// MARK: Private
private extension WebDomainView {
    func time() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: item.totalActivityDuration) ?? ""
    }
}
