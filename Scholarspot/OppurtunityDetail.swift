//
//  OppurtunityDetail.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 7/4/24.
//

import SwiftUI

struct OpportunityDetail: View {
    var opportunity: Opportunity

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(opportunity.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 20)
                    .padding(.horizontal)

                Text(opportunity.company)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                Text("Type: \(opportunity.type)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.horizontal)

                Text("Mode: \(opportunity.mode)")
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .padding(.horizontal)

                Text("Cost: \(opportunity.cost)")
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .padding(.horizontal)

                Text("Grades: \(opportunity.grades)")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.horizontal)

                Text("Field: \(opportunity.field)")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    ForEach(opportunity.description, id: \.self) { line in
                        Text(line)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.horizontal)

                Text("Deadline: \(opportunity.deadline)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(isPastDeadline(opportunity.deadline) ? .red : .black)
                    .padding(.horizontal)

                Text(opportunity.status)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
            }
            .navigationBarTitle(opportunity.title)
            .padding()
        }
    }

    func isPastDeadline(_ deadline: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let deadlineDate = dateFormatter.date(from: deadline) {
            return deadlineDate < Date()
        }
        return false
    }
}

struct OpportunityDetail_Previews: PreviewProvider {
    static var previews: some View {
        OpportunityDetail(opportunity: Opportunity(
            id: "", title: "Sample Opportunity Title",
            company: "Sample Company",
            mode: "Virtual",
            cost: "Free",
            grades: "9th-12th",
            field: "STEM Fields",
            type: "Summer Program",
            description: [
                "Sample description line 1",
                "Sample description line 2"
            ],
            status: "Posted 2 days ago",
            deadline: "07/15/2024",
            isNew: true
        ))
    }
}

