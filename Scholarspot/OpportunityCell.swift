//
//  OpportunityCell.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//

import SwiftUI

struct OpportunityCell: View {
    var opportunity: Opportunity
    
    var body: some View {
        Button(action: {
            print("OpportunityCell tapped")
        }) {
            VStack(alignment: .leading, spacing: 16) {
                if opportunity.isNew {
                    Text("New")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.pink)
                        .cornerRadius(4)
                }
                
                Text(opportunity.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(opportunity.company)
                    .font(.body)
                    .foregroundColor(.gray)
                
                HStack {
                    Text(opportunity.cost)
                        .foregroundColor(.green)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(4)
                    
                    Text(opportunity.mode)
                        .foregroundColor(.green)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(4)
                    
                    Text(opportunity.grades)
                        .foregroundColor(.black)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)
                    
                    Text(opportunity.field)
                        .foregroundColor(.black)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)
                }
                
                HStack {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                    Text("Easily apply")
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(opportunity.description, id: \.self) { item in
                        Text("• \(item)")
                    }
                }
                .foregroundColor(.gray)
                .font(.body)
                
                Text(opportunity.status)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if let deadlineDate = convertToDate(from: opportunity.deadline) {
                    Text("Deadline: \(formattedDeadline(deadline: deadlineDate))")
                        .font(.caption)
                        .foregroundColor(isPastDeadline(deadline: deadlineDate) ? .red : .gray)
                } else {
                    Text("Invalid Deadline Format")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func convertToDate(from dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: dateString)
    }
    
    func isPastDeadline(deadline: Date) -> Bool {
        return deadline < Date()
    }
    
    func formattedDeadline(deadline: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: deadline)
    }
}

struct OpportunityCell_Previews: PreviewProvider {
    static var previews: some View {
        OpportunityCell(opportunity: Opportunity(id: "1", title: "Sample Title", company: "Sample Company", mode: "Full-Time", cost: "Free", grades: "9th, 10th", field: "Science", type: "Internship", description: ["Description"], status: "Open", deadline: "06/30/2024", isNew: true))
    }
}
