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
            Spacer()
            Text(activity.title)
                .font(.largeTitle)
                .bold()
                .padding()
            Text(activity.description)
                .font(.title2)
            Text("\(activity.minutes) minutes")
                .font(.title3)
            Text(showCountMessage(count: activity.completionCount))
                .font(.title3)
            Button("Increment") {
                let newActivity = Activity(title: activity.title, description: activity.description, minutes: activity.minutes, completionCount: activity.completionCount + 1)
                let index = activities.items.firstIndex(of: activity)
                activities.items[index!] = newActivity
                dismiss()
            }
            .font(.title2)
            .bold()
            .padding()
            .background(.black)
            .foregroundColor(.white)
            .clipShape(.rect(cornerRadius: 10))
            Spacer()
            Spacer()
        }
    }
    
    func showCountMessage(count: Int) -> String {
        if count == 1 {
            return "Completed 1 time"
        }
        return "Completed \(count) times"
    }
}

#Preview {
    let activity = Activity(title: "Walk the dog", description: "Exercise for me and Spot", minutes: 30, completionCount: 1)
    let activities = Activities()
    
    return ActivityDetailView(activity: activity, activities: activities)
}
