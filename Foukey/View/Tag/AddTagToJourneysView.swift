//
//  AddTagToJourneysView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

struct AddTagToJourneysView: View {
    
    let journey: Journey
    
    @State private var searchTerm: String = ""
  
    @State private var selectedTags = Set<Tag>()
    @State private var tagSorting = TagSorting.aToZ
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            TagListView(searchTerm: searchTerm,
                        sorting: tagSorting,
                        selectedTags: $selectedTags,
                        journey: journey)
            .padding(.horizontal)
            .navigationTitle("[ \(journey.title) ]에 태그 추가")
             #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .searchable(text: $searchTerm,
                        placement: .navigationBarDrawer(displayMode: .always))
            .toolbar(content: {
                Menu {
                    Picker(selection: $tagSorting.animation()) {
                        ForEach(TagSorting.allCases) { tag in
                            Text(tag.title)
                        }
                    } label: {
                        Text("Sort Tags by")
                    }
                    
                } label: {
                    Image(systemName: "slider.horizontal.3")
                      
                }
                
            })
        }
        .frame(minWidth: 300, minHeight: 300)
    }
}

#Preview {
    ModelPreview { journey in
        NavigationView(content: {
            AddTagToJourneysView(journey: journey)
        })
       
    }
}
