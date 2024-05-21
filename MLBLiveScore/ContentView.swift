//import SwiftUI
//import Kingfisher
//
//
//
//struct ContentView: View {
//    let circleWidth: CGFloat
//    let space: CGFloat
//    let alignment: Alignment
//    let teamSpace: CGFloat
//    init(alignment: Alignment, circleWidth: CGFloat, teamSpace: CGFloat) {
//        self.circleWidth = circleWidth
//        self.alignment = alignment
//        space = circleWidth / 10
//        self.teamSpace = teamSpace
//    }
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            if alignment == .leading {
//                
//                VStack {
//                    Rectangle()
//                        .frame(width: 1, height: circleWidth + (teamSpace * 2) + 20)
//                }
//                
//                VStack(spacing: circleWidth + (teamSpace * 2) + 20 ) {
//                    Rectangle()
//                        .frame(width: circleWidth / 7, height: 1)
//                    
//                    Rectangle()
//                        .frame(width: circleWidth / 7, height: 1)
//                }
//            }
//            
//            VStack(spacing: teamSpace) {
//                HStack(spacing: 0) {
//                    Circle()
//                        .frame(width: circleWidth, height: circleWidth)
//                }
//                
//                Text("1-1")
//                    .frame(width: circleWidth, height: 20)
//                    .opacity(0.0)
//                
//                HStack(spacing: 0) {
//                    Circle()
//                        .frame(width: circleWidth, height: circleWidth)
//                }
//            }
//            
//            if alignment == .trailing {
//                VStack(spacing: circleWidth + (teamSpace * 2) + 20 ) {
//                    Rectangle()
//                        .frame(width: circleWidth / 7, height: 1)
//                    
//                    Rectangle()
//                        .frame(width: circleWidth / 7, height: 1)
//                }
//                
//                VStack {
//                    Rectangle()
//                        .frame(width: 1, height: circleWidth + (teamSpace * 2) + 20)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    HStack {
//        VStack(spacing: 20) {
//            ContentView(alignment: .trailing, circleWidth: 50, teamSpace: 6)
//            ContentView(alignment: .trailing, circleWidth: 50, teamSpace: 6)
//        }
//        
//        VStack(spacing: 40) {
//            ContentView(alignment: .trailing, circleWidth: 20, teamSpace: 6)
//            ContentView(alignment: .trailing, circleWidth: 20, teamSpace: 6)
//        }
//        .offset(y: 35)
//        
//        VStack {
//            ContentView(alignment: .trailing, circleWidth: 20, teamSpace: 50)
//        }
//        .offset(y: 40)
//        
//        VStack {
//            HStack {
//                Circle()
//                    .frame(width: 30, height: 30)
//                
//                Circle()
//                    .frame(width: 30, height: 30)
//            }
//            
////            Circle()
////                .frame(width: 50, height: 50)
//        }
//        .offset(y: 60)
//        
//        VStack {
//            ContentView(alignment: .leading, circleWidth: 20, teamSpace: 50)
//        }
//        .offset(y: 40)
//        
//        VStack(spacing: 40) {
//            ContentView(alignment: .leading, circleWidth: 20, teamSpace: 6)
//            ContentView(alignment: .leading, circleWidth: 20, teamSpace: 6)
//        }
//        .offset(y: 35)
//        
//        VStack(spacing: 20) {
//            ContentView(alignment: .leading, circleWidth: 50, teamSpace: 6)
//            ContentView(alignment: .leading, circleWidth: 50, teamSpace: 6)
//        }
//    }
//}
