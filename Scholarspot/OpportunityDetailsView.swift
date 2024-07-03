//
//  OpportunityDetailsView.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//
import SwiftUI

struct OpportunityDetailsView: View {
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
    @Binding var deadline: Date
    @Binding var isNew: Bool

    var body: some View {
        VStack(spacing: 20) {
            TextField("Title", text: $title)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            
            TextField("Company", text: $company)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            
            Picker("Mode", selection: $mode) {
                Text("Hybrid").tag("Hybrid")
                Text("Online").tag("Online")
                Text("In Person").tag("In Person")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            Slider(value: $cost, in: 0...5000, step: 100)
                .padding(.horizontal)
            Text("Cost: \(cost, specifier: "%.0f")")
                .padding(.horizontal)
            
            if cost > 5000 {
                TextField("Custom Cost", text: $customCost)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
            }
            
            TextEditor(text: $opportunityDescription)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                .frame(height: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .padding(.horizontal)

            NavigationLink(destination: GradeFieldSelectionView(
                selectedGrades: $selectedGrades,
                selectedField: $selectedField,
                title: $title,
                company: $company,
                mode: $mode,
                cost: $cost,
                customCost: $customCost,
                type: $type,
                opportunityDescription: $opportunityDescription,
                status: $status,
                deadline: $deadline,
                isNew: $isNew
            )) {
                Text("Next")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Opportunity Details")
    }
}

#Preview {
    OpportunityDetailsView(
        title: .constant("Sample Title"),
        company: .constant("Sample Company"),
        mode: .constant("Hybrid"),
        cost: .constant(1000),
        customCost: .constant(""),
        selectedGrades: .constant(["9th", "10th"]),
        selectedField: .constant("Science"),
        type: .constant("Internship"),
        opportunityDescription: .constant("This is a sample opportunity description."),
        status: .constant("Open"),
        deadline: .constant(Date()),
        isNew: .constant(true)
    )
}
