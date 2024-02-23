//
//  ActivityDetailView.swift
//  ActivityTracker
//
//  Created by Woodrow Martyr on 20/2/2024.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.dismiss) var dismiss
    var activity: Activity
    var activities: Activities
    
    var body: some View {
        VStack {
            Text(activity.title)
            Text(activity.description)
            Text("\(activity.minutes) minutes")
            Text(String(activity.completionCount))
            Button("Increment") {
                let newActivity = Activity(title: activity.title, description: activity.description, minutes: activity.minutes, completionCount: activity.completionCount + 1)
                let index = activities.items.firstIndex(of: activity)
                activities.items[index!] = newActivity
                dismiss()
            }
        }
    }
}

#Preview {
    let activity = Activity(title: "Walk the dog", description: "Exercise for me and Spot", minutes: 30, completionCount: 1)
    let activities = Activities()
    
    return ActivityDetailView(activity: activity, activities: activities)
}
