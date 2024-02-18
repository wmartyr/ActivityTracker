//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Woodrow Martyr on 12/2/2024.
//

import SwiftUI

struct Activity: Identifiable {
    var id = UUID()
    let title: String
    let description: String
    var hours: Double
}

@Observable
class Activities {
    var items = [Activity(title: "Walking", description: "Walking the dog", hours: 1.0)]
}


struct ContentView: View {
    @State private var activities = Activities()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(activities.items) {activity in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(activity.title)
                                    .font(.headline)
                                Text(activity.description)
                            }
                            Spacer()
                            Text("\(activity.hours, specifier: "%.1f") hours")
                        }
                        .padding()
                    }
                }
            }
            NavigationLink("Add New Activity") {
                AddActivityView(activities: activities)
            }
            .navigationTitle("Activity Tracker")
        }
    }
}

#Preview {

    ContentView()
}
