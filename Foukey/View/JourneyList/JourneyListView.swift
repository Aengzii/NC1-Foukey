//
//  JourneyListView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

struct JourneyListView: View {
    
    let folder: Folder
    
    @Query(sort: \Journey.creationDate, order: .reverse)
    var journeys: [Journey]
    
    @Binding var selectedJourney: Journey?
    
    init(for folder: Folder, selectedJourney: Binding<Journey?>) {

        let id = folder.uuid  // workaround: optional fetch
        
        self._journeys = Query(filter: #Predicate {
            $0.folder?.uuid == id
        }, sort: \.creationDate)
   
        
        self.folder = folder
        self._selectedJourney = selectedJourney
    }
    @State private var showRenameEditor: Bool = false
    
    var body: some View {
        
        List(selection: $selectedJourney) {
           ForEach(journeys) { journey in
                JourneyRow(journey: journey)
                .tag(journey)
                .swipeActions {
                    Button(role: .destructive) {
                        Journey.delete(journey)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    Button(action: {
                        journeyRenameAction()
                    }, label: {
                        Label("Rename", systemImage: "pencil")
                    })

                }
                .contextMenu {
                    
                    Button("Rename") {
                        journeyRenameAction()
                    }
                    Button("Delete") {
                        Folder.delete(folder)
                    }
                }
                .sheet(isPresented: $showRenameEditor, content: {
                    TitleEditorView(journey: journey)
                        .presentationDetents([.height(200)])
                        .presentationCornerRadius(15)
                })
            }
           
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: addItem) {
                    Label("Add Journey", systemImage: "note.text.badge.plus")
                }
            }
        }
        .navigationTitle(folder.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addItem() {
        withAnimation {
            let journey = Journey(title: "new journey")
            //journey.folder = folder
            folder.journeys.append(journey)
            selectedJourney = journey
        }
    }
    func journeyRenameAction() {
        #if os(OSX)
        textFieldIsSelected = true
        #else
        showRenameEditor = true
        #endif
    }
}

private struct PreviewJourneyListView: View {
    @Query(sort: \Folder.creationDate, order: .forward)
    private var folders: [Folder]
    
    var body: some View {
        JourneyListView(for: folders[0],
                        selectedJourney: .constant(nil))
    }
}

struct JouneyListView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewJourneyListView()
        
      // SnippetListView(for: Folder.exampleWithSnippets(),
      //                         selectedSnippet: .constant(nil))
            .modelContainer(PreviewSampleData.container)
    }
}

