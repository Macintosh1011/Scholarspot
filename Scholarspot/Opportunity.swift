//
//  Opportunity.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//
import Foundation

struct Opportunity: Decodable, Identifiable {
    var id: String
    var title: String
    var company: String
    var mode: String
    var cost: String
    var grades: String
    var field: String
    var type: String
    var description: [String]
    var status: String
    var deadline: String // This should be Date type instead of String
    var isNew: Bool
    
    init(id: String, title: String, company: String, mode: String, cost: String, grades: String, field: String, type: String, description: [String], status: String, deadline: String, isNew: Bool) {
        self.id = id
        self.title = title
        self.company = company
        self.mode = mode
        self.cost = cost
        self.grades = grades
        self.field = field
        self.type = type
        self.description = description
        self.status = status
        self.deadline = deadline // Assigning the deadline directly as a String
        self.isNew = isNew
    }
    
    // Optionally, you can provide a method to convert to dictionary
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "company": company,
            "mode": mode,
            "cost": cost,
            "grades": grades,
            "field": field,
            "type": type,
            "description": description,
            "status": status,
            "deadline": deadline, // No need for conversion here if you keep deadline as String
            "isNew": isNew
        ]
    }
}
