//
//  FilterDropdown.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//

import SwiftUI

struct FilterDropdown: View {
    var title: String
    @Binding var selection: String
    var options: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.bottom, 2)

            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selection = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selection)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 2)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    FilterDropdown(title: "Mode", selection: .constant("All"), options: ["All", "In person", "Online"])
}

