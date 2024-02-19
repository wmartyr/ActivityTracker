//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Woodrow Martyr on 12/2/2024.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    var minutes: Int
}

@Observable
class Activities {
    //var items = [Activity(title: "Walking", description: "Walking the dog", hours: 1.0)]
    var items = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                    UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
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
                            Text("\(activity.minutes) minutes")
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
