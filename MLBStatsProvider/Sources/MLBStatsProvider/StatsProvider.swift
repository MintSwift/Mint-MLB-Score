//
//  File.swift
//  
//
//  Created by Junghoon on 2024/05/20.
//

import Foundation
import MLBResponse

public struct StatsProvider {
    public static func allSchedule() async {
        let response = await Provider.fetch(.allSchedule, type: MLBScheduleResponse.self)
        print(response)
    }
}
