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
        
        let utc = "2024-05-14"
        let utcDate = utc.toISODate(region: .UTC)?.date
        let utcString = utcDate?.toString()
        print(utcString)
        
    }
    var body: some Scene {
        WindowGroup {
            DailyScheduleView()
        }
    }
}
