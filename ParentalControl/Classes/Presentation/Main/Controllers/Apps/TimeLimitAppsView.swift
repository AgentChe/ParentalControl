//
//  TimeLimitAppsView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 02.11.2023.
//

import SwiftUI
import DeviceActivity
import ManagedSettings

struct TimeLimitAppsView: View {
    enum Rule {
        case enable, empty
    }
    
    let rule: Rule
    
    @EnvironmentObject private var timeLimitApps: TimeLimitApps
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(Color(Appearance.background2))
            
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(Color(Appearance.white))
                .padding([.top, .leading, .trailing], 3.scale)
                .padding(.bottom, 6.scale)
            
            if enable {
                apps
            } else {
                empty
            }
        }
        .background(Color(Appearance.background))
    }
}

// MARK: Private
private extension TimeLimitAppsView {
    var enable: Bool {
        switch rule {
        case.empty:
            return !timeLimitApps.applicationsTokens.isEmpty
        case .enable:
            return timeLimitApps.isEnable
        }
    }
    
    var empty: some View {
        HStack {
            VStack {
                Text("Apps.TimeLimit".localized)
                    .foregroundColor(Color(Appearance.black))
                    .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Downtime.NotSet".localized)
                    .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                    .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
            Image("Downtimes.Arrow.Right")
                .resizable()
                .frame(width: 24.scale, height: 24.scale)
        }
        .padding(16.scale)
    }
    
    var apps: some View {
        HStack {
            VStack {
                Text("Apps.TimeLimit".localized)
                    .foregroundColor(Color(Appearance.black))
                    .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    ZStack(alignment: .leading) {
                        ForEach(Array(timeLimitApps.applicationsTokens.prefix(3).enumerated()), id: \.offset) { offset, token in
                            Label(token)
                                .labelStyle(.iconOnly)
                                .frame(width: 40.scale, height: 40.scale)
                                .padding(.leading, CGFloat(offset) * 24.scale)
                                .border(Color.white, width: 1.scale)
                        }
                    }
                    
                    if timeLimitApps.applicationsTokens.count > 3 {
                        Text("+\(timeLimitApps.applicationsTokens.count - 3)")
                            .foregroundColor(Color(Appearance.secondary))
                            .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                    }
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Image("Downtimes.Arrow.Right")
                .resizable()
                .frame(width: 24.scale, height: 24.scale)
        }
        .padding(16.scale)
    }
}
