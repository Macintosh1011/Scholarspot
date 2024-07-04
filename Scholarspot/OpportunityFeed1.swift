//
//  OpportunityFeed.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//

import SwiftUI
import FirebaseDatabase

struct OpportunityFeed: View {
    @State private var selectedMode: String = "All"
    @State private var selectedCost: String = "All"
    @State private var selectedGrades: String = "All"
    @State private var selectedField: String = "All"
    @State private var selectedType: String = "All"
    @State private var searchText: String = ""
    @State private var showFilters: Bool = false
    @State private var opportunities: [Opportunity] = []
    @State private var showingUploadView = false

    var filteredOpportunities: [Opportunity] {
        opportunities.filter { opportunity in
            (selectedMode == "All" || opportunity.mode == selectedMode) &&
            (selectedCost == "All" || opportunity.cost == selectedCost) &&
            (selectedGrades == "All" || gradeMatches(selectedGrades, opportunity.grades)) &&
            (selectedField == "All" || opportunity.field == selectedField) &&
            (selectedType == "All" || opportunity.type == selectedType) &&
            (searchText.isEmpty || opportunity.title.localizedCaseInsensitiveContains(searchText) ||
             opportunity.company.localizedCaseInsensitiveContains(searchText) ||
             opportunity.description.joined(separator: " ").localizedCaseInsensitiveContains(searchText))
        }
    }

    func gradeMatches(_ selectedGrade: String, _ opportunityGrades: String) -> Bool {
        guard selectedGrade != "All" else { return true }
        
        let selectedGradeValue = selectedGrade.replacingOccurrences(of: "th", with: "")
        
        if opportunityGrades.contains("-") {
            let gradesRange = opportunityGrades.split(separator: "-").map { String($0) }
            if let startGrade = gradesRange.first?.replacingOccurrences(of: "th", with: ""),
               let endGrade = gradesRange.last?.replacingOccurrences(of: "th", with: "") {
                return (Int(startGrade) ?? 0)...(Int(endGrade) ?? 0) ~= (Int(selectedGradeValue) ?? 0)
            }
        } else {
            return opportunityGrades.replacingOccurrences(of: "th", with: "") == selectedGradeValue
        }
        
        return false
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        showFilters.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title)
                    }
                    .sheet(isPresented: $showFilters) {
                        FilterView(
                            selectedMode: $selectedMode,
                            selectedCost: $selectedCost,
                            selectedGrades: $selectedGrades,
                            selectedField: $selectedField,
                            selectedType: $selectedType,
                            onApplyFilters: {
                                showFilters = false
                            }
                        )
                    }
                }
                .padding(.top)

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(filteredOpportunities) { opportunity in
                            OpportunityCell(opportunity: opportunity)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Opportunities")
                .navigationBarItems(trailing: Button(action: {
                    showingUploadView.toggle()
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                })
                .sheet(isPresented: $showingUploadView) {
                    UploadOpportunityView()
                }
            }
            .onAppear {
                fetchOpportunities()
            }
        }
    }

    func fetchOpportunities() {
        let ref = Database.database().reference(withPath: "opportunities")
        ref.observe(.value) { snapshot in
            var newOpportunities: [Opportunity] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let opportunity = try? snapshot.decode(as: Opportunity.self) {
                    print("Fetched Opportunity: \(opportunity)")
                    newOpportunities.append(opportunity)
                } else {
                    print("Error decoding snapshot: \(child)")
                }
            }
            opportunities = newOpportunities
            print("Total opportunities fetched: \(opportunities.count)")
        }
    }

}

#Preview {
    OpportunityFeed()
}

extension DataSnapshot {
    func decode<T: Decodable>(as type: T.Type) throws -> T {
        do {
            let data = try JSONSerialization.data(withJSONObject: self.value as Any)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error decoding snapshot: \(error)")
            throw error
        }
    }
}

