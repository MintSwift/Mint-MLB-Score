//
//  IntentHandler.swift
//  MLBTeamIntents
//
//  Created by Junghoon on 2024/05/20.
//

import Intents
import UIKit


class IntentHandler: INExtension {
    let teams = MLBTeam.all
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler: TeamIntentHandling {
    
    func provideTeamOptionsCollection(for intent: TeamIntent) async throws -> INObjectCollection<MLBClubTeam> {      
        
        var clubs: [MLBClubTeam] = []
        for team in teams {
            let club = MLBClubTeam(identifier: UUID().uuidString,
                                   display: team.name,
                                   subtitle: team.location,
                                   image: INImage(named: team.abbreviation))
            clubs.append(club)
            
        }
        let collection = INObjectCollection(items: clubs)
    
        return collection
    }
}
