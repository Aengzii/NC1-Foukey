//
//  NewTagView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI

struct NewTagView: View {
    
    let journey: Journey
    let searchTerm: String
    
    let colorOptions = [Color(red: 1, green: 0, blue: 0),
                        Color(red: 1, green: 0, blue: 1),
                        Color(red: 1, green: 1, blue: 0),
                        Color(red: 0, green: 0, blue: 1),
                        Color(red: 0, green: 1, blue: 1),
                        Color(red: 0, green: 1, blue: 0)]
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedColor = Color(red: 0, green: 0, blue: 0)
    
    var body: some View {
        
        VStack {
            
            HStack {
                ForEach(colorOptions) { color in
                    Circle().fill(color)
                        .frame(width: selectedColor == color ? 20 : 15)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            
            Button {
                let tag = Tag(name: searchTerm)
                tag.color = selectedColor
                journey.tags.append(tag)
                
                dismiss()
            } label: {
                Text("태그 만들기")
            }
            .disabled(searchTerm.count == 0)
            .buttonStyle(.bordered)
            .padding()
        }
    }
}

extension Color: Identifiable {
    public var id: String {
        var id = ""
        guard let components = self.cgColor?.components else {
            return id
        }
        for component in components {
            id.append(" \(component)")
        }
        return id
    }
}


#Preview {
    ModelPreview { journey in
        NewTagView(journey: journey, searchTerm: "test")
    }
}

