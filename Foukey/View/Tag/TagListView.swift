//
//  TagListView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

struct TagListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: \Tag.name, order: .forward, animation: .easeInOut)
    var tags: [Tag]
    
    @Binding var selectedTags: Set<Tag>
    let journey: Journey
    let searchTerm: String
    
    init(searchTerm: String,
         sorting: TagSorting,
         selectedTags: Binding<Set<Tag>>,
         journey: Journey) {
        self._selectedTags = selectedTags
        self.journey = journey
        self.searchTerm = searchTerm
    
        //MARK: - fixed with Xcode 15 beta 7
        //update query works without crashing the app
        //@Query changed from propery wrapper to swift macro
        
        if searchTerm.count > 0 {
            self._tags = Query(filter: #Predicate<Tag> {
                $0.name.contains(searchTerm)
            }, sort: [sorting.sortDescriptor], animation: .easeInOut)
            
        } else {
            self._tags = Query(sort: [sorting.sortDescriptor], animation: .easeInOut)
        }
    }
    
    var body: some View {
        List(selection: $selectedTags) {
            ForEach(tags) { tag in
                HStack {
                    Image(systemName: "tag.fill")
                        .foregroundColor(tag.color)
                    Text(tag.name)
                    
                    Spacer()
                    
                    Text(String(tag.journeys.count))
                }
                .tag(tag)
            }
        }
        .listStyle(.plain)
        .frame(minHeight: 150)
        
        if selectedTags.count > 0 {
            Button {
                selectedTags.forEach { tag in
                    journey.tags.append(tag)
                }
                dismiss()
            } label: {
                Text("Add keywords to note")
            }
        } else if tags.count == 0 {
            NewTagView(journey: journey,
                       searchTerm: searchTerm)
        }
        
    }
}

#Preview {
    ModelPreview { journey in
        VStack {
            TagListView(searchTerm: "",
                        sorting: .aToZ,
                        selectedTags: .constant([]),
                        journey: journey)
        }
    }
}

#Preview("without search results") {
    ModelPreview { journey in
        VStack {
            TagListView(searchTerm: "test",
                        sorting: .aToZ,
                        selectedTags: .constant([]),
                        journey: journey)
        }
    }
}




