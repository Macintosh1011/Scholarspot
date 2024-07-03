//
//  GradeSelectionView.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//

import SwiftUI

struct GradeFieldSelectionView: View {
    @Binding var selectedGrades: [String]
    @Binding var selectedField: String
    @Binding var title: String
    @Binding var company: String
    @Binding var mode: String
    @Binding var cost: Double
    @Binding var customCost: String
    @Binding var type: String
    @Binding var opportunityDescription: String
    @Binding var status: String
    @Binding var deadline: Date
    @Binding var isNew: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Grades")
                .font(.headline)
            
            ForEach(["9th", "10th", "11th", "12th"], id: \.self) { grade in
                Toggle(grade, isOn: Binding<Bool>(
                    get: { self.selectedGrades.contains(grade) },
                    set: { newValue in
                        if newValue {
                            self.selectedGrades.append(grade)
                        } else {
                            self.selectedGrades.removeAll { $0 == grade }
                        }
                    }
                ))
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            }

            Text("Select Field")
                .font(.headline)

            Picker("Field", selection: $selectedField) {
                Text("Science").tag("Science")
                Text("Technology").tag("Technology")
                Text("Engineering").tag("Engineering")
                Text("Mathematics").tag("Mathematics")
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)

            NavigationLink(destination: DeadlineSelectionView(
                deadline: $deadline,
                title: $title,
                company: $company,
                mode: $mode,
                cost: $cost,
                customCost: $customCost,
                selectedGrades: $selectedGrades,
                selectedField: $selectedField,
                type: $type,
                opportunityDescription: $opportunityDescription,
                status: $status,
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
        .navigationTitle("Select Grades & Field")
    }
}

#Preview {
    GradeFieldSelectionView(
        selectedGrades: .constant(["9th"]),
        selectedField: .constant("Science"),
        title: .constant("Sample Title"),
        company: .constant("Sample Company"),
        mode: .constant("Hybrid"),
        cost: .constant(1000),
        customCost: .constant(""),
        type: .constant("Internship"),
        opportunityDescription: .constant("This is a sample opportunity description."),
        status: .constant("Open"),
        deadline: .constant(Date()),
        isNew: .constant(true)
    )
}
