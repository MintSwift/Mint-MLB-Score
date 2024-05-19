//
//  MLBLiveWidgetBundle.swift
//  MLBLiveWidget
//
//  Created by Junghoon on 2024/05/16.
//

import WidgetKit
import SwiftUI
import SwiftDate

@main
struct MLBLiveWidgetBundle: WidgetBundle {
    
    init() {
        let timezone: Zones = Zones.current
        let calendar: Calendars = Calendars.gregorian
        let locale: Locales = Locales.current
        
        SwiftDate.defaultRegion = Region(calendar: calendar, zone: timezone, locale: locale)
    }
    
    var body: some Widget {
        MLBLiveWidget()
    }
}
