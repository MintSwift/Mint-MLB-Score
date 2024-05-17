import SwiftUI
import Kingfisher
import SwiftDate

struct DiamondView: View {
    let runner: Runner?
    
    init(runner: Runner?) {
        self.runner = runner
    }

    var body: some View {
        ZStack {
            Image(systemName: "diamond.fill")
                .resizable()
                .foregroundStyle(.green)
                .opacity(0.8)
                .frame(width: 150, height: 150, alignment: .center)
                .overlay(alignment: .top) {
                    Image(systemName: "diamond.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 40, height: 40, alignment: .center)
                        .offset(y: -10.0)
                }
                .overlay(alignment: .leading) {
                    Image(systemName: "diamond.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 40, height: 40, alignment: .center)
                        .offset(x: -10.0)
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: "diamond.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 40, height: 40, alignment: .center)
                        .offset(x: 10.0)
                }
                .overlay(alignment: .bottom) {
                    Image(systemName: "rectangle.fill")
                        .resizable()
                        .foregroundStyle(.yellow)
                        .frame(width: 30, height: 30, alignment: .center)
                        .offset(y: 10.0)
                }
                .padding(.bottom, 10)
//
            Rectangle()
                .foregroundStyle(.clear)
                .opacity(0.2)
                .frame(width: 155, height: 155, alignment: .center)
                .overlay(alignment: .top) {
                    if let id = runner?.second.number {
                        KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(id)/spots/90"))
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                }
                .overlay(alignment: .leading) {
                    if let id = runner?.third.number {
                        KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(id)/spots/90"))
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                        
                    }
                }
                .overlay(alignment: .trailing) {
                    if let id = runner?.first.number {
                        KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(id)/spots/90"))
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                }
                .overlay(alignment: .bottom, content: {
                    if let id = runner?.batter.number {
                        KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(id)/spots/90"))
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                })
                .padding(.bottom, 10)
//
            Rectangle()
                .foregroundStyle(.clear)
                .opacity(0.2)
                .frame(width: 155 * 2, height: 155, alignment: .center)
                .overlay(alignment: .top) {
                    if let name = runner?.second.name {
                        Text(name)
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            }
                            .offset(y: -34.0)
                    }
                }
                .overlay(alignment: .leading) {
                    if let name = runner?.third.name {
                        Text(name)
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            }
                            .offset(y: 20)
                    }
                }
                .overlay(alignment: .trailing) {
                    if let name = runner?.first.name {
                        Text(name)
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            }
                            .offset(x: -30, y: 30)
                    }
                }
                .overlay(alignment: .bottom, content: {
                    if let name = runner?.batter.name {
                        Text(name)
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            }
                            .offset(y: 25)
                    }
                })
        }
    }
}
