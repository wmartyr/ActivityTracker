//
//  AddActivityView.swift
//  ActivityTracker
//
//  Created by Woodrow Martyr on 13/2/2024.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = "Activity Title"
    @State private var description = "Activity Description"
    @State private var hours = 0.0
    
    
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Title", text: $title)
                }
                Section("Description") {
                    TextField("Description", text: $description)
                }
                Section("Hours") {
                    TextField("Hours", value: $hours, format: .number)
                }
            }
            .navigationTitle("Add Activity")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let activity = Activity(title: title, description: description, hours: hours)
                        activities.items.append(activity)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}
