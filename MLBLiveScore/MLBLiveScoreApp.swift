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
    init() {
        let timezone: Zones = Zones.asiaSeoul
        let calendar: Calendars = Calendars.gregorian
        let locale: Locales = Locales.korean
        
        SwiftDate.defaultRegion = Region(calendar: calendar, zone: timezone, locale: locale)
    }
    
    var body: some Scene {
        WindowGroup {
            DailyScheduleView()
        }
    }
}
