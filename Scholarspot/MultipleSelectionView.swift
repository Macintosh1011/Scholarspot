//
//  MultipleSelectionView.swift
//  Scholarspot
//
//  Created by Idan Kestenbom on 6/29/24.
//

import SwiftUI

struct MultipleSelectionView: View {
    @Binding var selection: [String]
    let options: [String]
    
    var body: some View {
        VStack {
            ForEach(options, id: \.self) { option in
                HStack {
                    Text(option)
                    Spacer()
                    if selection.contains(option) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if selection.contains(option) {
                        selection.removeAll { $0 == option }
                    } else {
                        selection.append(option)
                    }
                }
                .padding()
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding()
    }
}

#Preview {
    MultipleSelectionView(
        selection: .constant([]),
        options: ["9th", "10th", "11th", "12th"]
    )
}

