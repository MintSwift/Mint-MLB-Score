//
//  MLBLiveWidget.swift
//  MLBLiveWidget
//
//  Created by Junghoon on 2024/05/16.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct InningsView : View {
    var body: some View {
        VStack(spacing: 3) {
            Text("Top 5")
            VStack {
                
            }
            .frame(width: 60, height: 43, alignment: .center)
            .background(alignment: .top) {
                Image(systemName: "diamond")
                    .resizable()
                    .foregroundStyle(.blue)
                    .frame(width: 27, height: 27, alignment: .center)
            }
            .background(alignment: .bottomLeading) {
                Image(systemName: "diamond.fill")
                    .resizable()
                    .foregroundStyle(.blue)
                    .frame(width: 27, height: 27, alignment: .center)
            }
            .background(alignment: .bottomTrailing) {
                Image(systemName: "diamond")
                    .resizable()
                    .foregroundStyle(.blue)
                    .frame(width: 27, height: 27, alignment: .center)
            }
            
            Text("2-1")
            
            HStack {
                ForEach(0...2, id: \.self) { index in
                    if (index) < Int(2) ?? 0 {
                        Circle()
                            .frame(width: 15, height: 15, alignment: .center)
                            .foregroundStyle(.red)
                    } else {
                        Circle()
                            .frame(width: 15, height: 15, alignment: .center)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .padding(.horizontal, 8)
    }
    
}

struct MLBLiveWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
//            Text("MLB")
//                .font(.body)
//                .frame(maxWidth: .infinity, alignment: .leading)
                
            
            HStack {
                
                VStack(spacing: 10) {
                    
                    VStack {
                        Text("Pittsburgh")
                        Text("Pirates")
                    }
                    .font(.caption2)
                    
                    Image("LAA")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    
                    VStack {
                        Text("20 - 23")
                        Text("3rd NL Central")
                        Text("Next Generation")
                    }
                    .foregroundStyle(.secondary)
                    .font(.caption2)
      
                }
                .containerRelativeFrame(.horizontal, count: 30, span: 9, spacing: 0)
                
                VStack {
                    Text("05.22")
                    Text("AM 11:23")
                }
                .foregroundStyle(.secondary)
                .font(.footnote)
                .containerRelativeFrame(.horizontal, count: 30, span: 7, spacing: 0)
                
                VStack(spacing: 10) {
                    
                    VStack {
                        Text("Pittsburgh")
                        Text("Pirates")
                    }
                    .font(.caption2)
                    
                    Image("LAD")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    
                    VStack {
                        Text("12 - 23")
                        Text("3rd AL Central")
                        Text("Next Generation")
                    }
                    .foregroundStyle(.secondary)
                    .font(.caption2)
                    
                }
                .containerRelativeFrame(.horizontal, count: 30, span: 9, spacing: 0)
            }
        }
    }
}

struct MLBLiveWidget: Widget {
    let kind: String = "MLBLiveWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MLBLiveWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MLBLiveWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemMedium) {
    MLBLiveWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}
