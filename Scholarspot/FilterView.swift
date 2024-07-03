//
//  FilterView.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedMode: String
    @Binding var selectedCost: String
    @Binding var selectedGrades: String
    @Binding var selectedField: String
    @Binding var selectedType: String
    var onApplyFilters: () -> Void

    let modes = ["All", "In person", "Virtual"]
    let costs = ["All", "Free", "Paid"]
    let grades = ["All", "9th", "10th", "11th", "12th"]
    let fields = ["All", "STEM Fields", "Computer Science", "Med", "Law"]
    let types = ["All", "Internship", "Summer Program", "Research Program", "Affinity Club", "Competition", "Hackathon"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Mode")) {
                    Picker("Mode", selection: $selectedMode) {
                        ForEach(modes, id: \.self) { mode in
                            Text(mode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Cost")) {
                    Picker("Cost", selection: $selectedCost) {
                        ForEach(costs, id: \.self) { cost in
                            Text(cost)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Grades")) {
                    Picker("Grades", selection: $selectedGrades) {
                        ForEach(grades, id: \.self) { grade in
                            Text(grade)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Field")) {
                    Picker("Field", selection: $selectedField) {
                        ForEach(fields, id: \.self) { field in
                            Text(field)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Opportunity Type")) {
                    Picker("Opportunity Type", selection: $selectedType) {
                        ForEach(types, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Button(action: {
                    onApplyFilters()
                }) {
                    Text("Apply Filters")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
            }
            .navigationBarTitle("Filters", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                onApplyFilters()
            })
        }
    }
}

#Preview {
    FilterView(selectedMode: .constant("All"), selectedCost: .constant("All"), selectedGrades: .constant("All"), selectedField: .constant("All"), selectedType: .constant("All"), onApplyFilters: {})
}
