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
        NavigationLink(destination: OpportunityDetail(opportunity: opportunity)) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if opportunity.isNew {
                        Text("New")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.blue)
                            .cornerRadius(4)
                    }
                    Spacer()
                    Text("Deadline: \(formattedDeadline(deadline: opportunity.deadline))")
                        .font(.caption)
                        .foregroundColor(isPastDeadline(deadline: opportunity.deadline) ? .red : .gray)
                }
                
                HStack {
                    Text(opportunity.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                    Text(opportunity.status)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)
                }
                
                Text(opportunity.company)
                    .font(.body)
                    .foregroundColor(.gray)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                    HStack {
                        Image(systemName: "tag.fill")
                            .foregroundColor(.green)
                        Text(opportunity.cost)
                            .foregroundColor(.green)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(4)
                    
                    HStack {
                        Image(systemName: "briefcase.fill")
                            .foregroundColor(.blue)
                        Text(opportunity.mode)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
                    
                    HStack {
                        Image(systemName: "graduationcap.fill")
                            .foregroundColor(.orange)
                        Text(opportunity.grades)
                            .foregroundColor(.orange)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(4)
                    
                    HStack {
                        Image(systemName: "leaf.fill")
                            .foregroundColor(.purple)
                        Text(opportunity.field)
                            .foregroundColor(.purple)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
                    .background(Color.purple.opacity(0.1))
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
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
            .padding()
        }
    }
    
    func convertToDate(from dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: dateString)
    }
    
    func isPastDeadline(deadline: String) -> Bool {
        if let date = convertToDate(from: deadline) {
            return date < Date()
        }
        return false
    }
    
    func formattedDeadline(deadline: String) -> String {
        return deadline
    }
}

struct OpportunityCell_Previews: PreviewProvider {
    static var previews: some View {
        OpportunityCell(opportunity: Opportunity(
            id: "1",
            title: "Sample Title",
            company: "Sample Company",
            mode: "Online",
            cost: "0.0",
            grades: "9th, 10th, 11th",
            field: "Technology",
            type: "Internship",
            description: [
                "Project-based learning program where students form international teams and work with STEM experts through an online community platform.",
                "Students participate in innovation challenges where they collaborate under the guidance of STEM mentors to design solutions to real-world problems."
            ],
            status: "Closed",
            deadline: "07/01/2024",
            isNew: true
        ))
    }
}
