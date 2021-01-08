//
//  socialWidget.swift
//  socialWidget
//
//  Created by Ahmed Ragab on 8/5/20.
//  Copyright © 2020 Ahmed Ragab. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct socialWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        
        if family == .systemSmall{
        VStack (alignment:.leading,spacing:4){
            Text("Newest")
                .font(Font.footnote.smallCaps())
                .foregroundColor(.secondary)
            
            Image("test")
                .resizable()
                .cornerRadius(15)
                
            Text("Hellow From Paris With Socially App")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .padding(12)
        }
        else {
            VStack (alignment:.leading,spacing:4){
                Text("Newest")
                    .font(Font.footnote.smallCaps())
                    .foregroundColor(.secondary)
                
                Image("test")
                    .resizable()
                    clipShape(Rectangle())
                        .cornerRadius(5)
                    
                Text("Added an Amazing photo for the City of Paris with a great View")
                   
            }
            .padding(12)
        }
    }
}



@main
struct socialWidget: Widget {
    private let kind: String = "socialWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            socialWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Socially")
        .description("This is a Socially App widget.")
        .supportedFamilies([.systemSmall,.systemMedium])
    }
}

struct socialWidget_Previews: PreviewProvider {
    static var previews: some View {
        socialWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
