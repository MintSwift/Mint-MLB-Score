//
//  MLBLiveScoreApp.swift
//  MLBLiveScore
//
//  Created by Junghoon on 2024/05/09.
//

import SwiftUI
import SwiftDate

@main
struct MLBLiveScoreApp: App {
    @StateObject var interactor = ScheduleInteractor()
    
    init() {
        let timezone: Zones = Zones.asiaSeoul
        let calendar: Calendars = Calendars.gregorian
        let locale: Locales = Locales.korean
        
        SwiftDate.defaultRegion = Region(calendar: calendar, zone: timezone, locale: locale)
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                DailyScheduleView()
                    .environmentObject(interactor)
                
                AllScheduleView()
            }
//                    .tabItem {
//                        Label {
//                            Text("매일 일정")
//                        } icon: {
//                            Image(systemName: "baseball.fill")
//                            
//                        }
//
//                    }
//                TeamScheduleView()
//                    .tabItem {
//                        Label {
//                            Text("팀 일정")
//                        } icon: {
//                            Image(systemName: "calendar")
//                        }
//
//                    }
//            }
            
        }
    }
}
