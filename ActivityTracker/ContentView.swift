//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Woodrow Martyr on 12/2/2024.
//

import SwiftUI

struct Activity: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var minutes: Int
    var completionCount: Int
}

@Observable
class Activities {
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
            List {
                    ForEach(activities.items) {activity in
                        NavigationLink(value: activity) {
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
                        .navigationDestination(for: Activity.self) {selection in
                            ActivityDetailView(activity: selection, activities: activities)
                        }
                    }
                    .onDelete(perform: removeActivities)
            }
            NavigationLink("Add New Activity") {
                AddActivityView(activities: activities)
            }
            .navigationTitle("Activity Tracker")
        }
    }
    
    func removeActivities(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
