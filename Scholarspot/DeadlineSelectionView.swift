//
//  DeadlineSelectionView.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//

import SwiftUI

struct DeadlineSelectionView: View {
    @Binding var deadline: Date
    @Binding var title: String
    @Binding var company: String
    @Binding var mode: String
    @Binding var cost: Double
    @Binding var customCost: String
    @Binding var selectedGrades: [String]
    @Binding var selectedField: String
    @Binding var type: String
    @Binding var opportunityDescription: String
    @Binding var status: String
    @Binding var isNew: Bool
    
    @State private var deadlineString: String = "" // Holds formatted deadline string
    @State private var navigationActive: Bool = false // To control navigation activation

    var body: some View {
        VStack(spacing: 20) {
            DatePicker("Select Deadline", selection: $deadline, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)

            Toggle("Is New Opportunity", isOn: $isNew)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)

            TextField("Status", text: $status)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                .autocapitalization(.words)
                .disableAutocorrection(true)
            
            Button(action: {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                deadlineString = formatter.string(from: deadline)
                
                // Activate navigation
                navigationActive = true
            }) {
                Text("Next")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .background(
                NavigationLink("", destination:
                    ReviewAndSubmitView(
                        title: $title,
                        company: $company,
                        mode: $mode,
                        cost: $cost,
                        customCost: $customCost,
                        selectedGrades: $selectedGrades,
                        selectedField: $selectedField,
                        type: $type,
                        description: $opportunityDescription,
                        status: $status,
                        deadline: $deadlineString,
                        isNew: $isNew
                    ),
                    isActive: $navigationActive
                ).hidden()
            )

            Spacer()
        }
        .padding()
        .navigationTitle("Set Deadline & Status")
    }
}

#Preview {
    DeadlineSelectionView(
        deadline: .constant(Date()),
        title: .constant("Sample Title"),
        company: .constant("Sample Company"),
        mode: .constant("Hybrid"),
        cost: .constant(1000),
        customCost: .constant(""),
        selectedGrades: .constant(["9th"]),
        selectedField: .constant("Science"),
        type: .constant("Internship"),
        opportunityDescription: .constant("This is a sample opportunity description."),
        status: .constant("Open"),
        isNew: .constant(true)
    )
}
