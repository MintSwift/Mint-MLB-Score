import Foundation

public struct MLBTeam {
    public let code: Int
    public let name: String
    public let location: String
    public let abbreviation: String
    public let division: Division
    public let league: League
    
    public var all: [MLBTeam] = [
        MLBTeam.orioles,
        MLBTeam.redsox,
        MLBTeam.yankees,
        MLBTeam.bayrays,
        MLBTeam.bluejays,
        MLBTeam.whitesox,
        MLBTeam.guardians,
        MLBTeam.tigers,
        MLBTeam.royals,
        MLBTeam.twins,
        MLBTeam.astros,
        MLBTeam.angels,
        MLBTeam.athletics,
        MLBTeam.mariners,
        MLBTeam.rangers,
        MLBTeam.braves,
        MLBTeam.marlins,
        MLBTeam.mets,
        MLBTeam.phillies,
        MLBTeam.nationals,
        MLBTeam.cubs,
        MLBTeam.reds,
        MLBTeam.brewers,
        MLBTeam.pirates,
        MLBTeam.cardinals,
        MLBTeam.diamondbacks,
        MLBTeam.dodgers,
        MLBTeam.rockies,
        MLBTeam.padres,
        MLBTeam.giants
    ]
}
