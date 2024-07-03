//
//  ReviewandSubmitView.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//

import SwiftUI
import FirebaseDatabase

struct ReviewAndSubmitView: View {
    @Binding var title: String
    @Binding var company: String
    @Binding var mode: String
    @Binding var cost: Double
    @Binding var customCost: String
    @Binding var selectedGrades: [String]
    @Binding var selectedField: String
    @Binding var type: String
    @Binding var description: String
    @Binding var status: String
    @Binding var deadline: String
    @Binding var isNew: Bool

    func uploadOpportunity() {
        let ref = Database.database().reference(withPath: "opportunities")
        let opportunityId = ref.childByAutoId().key ?? UUID().uuidString
        
        let opportunity = Opportunity(
            id: opportunityId,
            title: title,
            company: company,
            mode: mode,
            cost: cost > 5000 ? (customCost.isEmpty ? "\(cost)" : customCost) : "\(cost)",
            grades: selectedGrades.joined(separator: ", "),
            field: selectedField,
            type: type,
            description: [description],
            status: status,
            deadline: deadline,
            isNew: isNew
        )
        
        ref.child(opportunityId).setValue(opportunity.toDictionary()) { error, _ in
            if let error = error {
                print("Error uploading opportunity: \(error.localizedDescription)")
            } else {
                print("Opportunity uploaded successfully")
                clearFields()
            }
        }
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Review Opportunity Details")) {
                    Text("Title: \(title)")
                    Text("Company: \(company)")
                    Text("Mode: \(mode)")
                    Text("Cost: \(cost, specifier: "%.0f")")
                    if !customCost.isEmpty {
                        Text("Custom Cost: \(customCost)")
                    }
                    Text("Grades: \(selectedGrades.joined(separator: ", "))")
                    Text("Field: \(selectedField)")
                    Text("Type: \(type)")
                    Text("Description: \(description)")
                    Text("Status: \(status)")
                    Text("Deadline: \(deadline)")
                    Toggle(isOn: $isNew) {
                        Text("New Opportunity")
                    }
                }
                
                Section {
                    Button(action: {
                        uploadOpportunity()
                    }) {
                        Text("Upload Opportunity")
                    }
                }
            }
            .navigationTitle("Review & Submit")
        }
    }

    func clearFields() {
        title = ""
        company = ""
        mode = ""
        cost = 0.0
        customCost = ""
        selectedGrades = []
        selectedField = ""
        type = ""
        description = ""
        status = ""
        deadline = ""
        isNew = false
    }
}

#Preview {
    ReviewAndSubmitView(
        title: .constant("Sample Title"),
        company: .constant("Sample Company"),
        mode: .constant("Hybrid"),
        cost: .constant(1000),
        customCost: .constant(""),
        selectedGrades: .constant(["9th", "10th"]),
        selectedField: .constant("Science"),
        type: .constant("Internship"),
        description: .constant("This is a sample opportunity description."),
        status: .constant("Open"),
        deadline: .constant("06/30/2024"),
        isNew: .constant(true)
    )
}
