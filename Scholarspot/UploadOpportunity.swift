//
//  UploadOpportunity.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//

import SwiftUI

struct UploadOpportunityView: View {
    @State private var title: String = ""
    @State private var company: String = ""
    @State private var mode: String = "Hybrid"
    @State private var cost: Double = 0.0
    @State private var customCost: String = ""
    @State private var selectedGrades: [String] = []
    @State private var selectedField: String = ""
    @State private var type: String = ""
    @State private var description: String = ""
    @State private var status: String = ""
    @State private var deadline: Date = Date()
    @State private var isNew: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "doc.text")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                
                Text("Upload New Opportunity")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)

                NavigationLink(destination: OpportunityDetailsView(
                    title: $title,
                    company: $company,
                    mode: $mode,
                    cost: $cost,
                    customCost: $customCost,
                    selectedGrades: $selectedGrades,
                    selectedField: $selectedField,
                    type: $type,
                    opportunityDescription: $description,
                    status: $status,
                    deadline: $deadline,
                    isNew: $isNew
                )) {
                    Text("Start Upload")
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
            .navigationTitle("Upload Opportunity")
            .padding()
        }
    }
}

#Preview {
    UploadOpportunityView()
}
