//
//  ContentView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedFolder: Folder? = nil
    @State private var selectedJourney: Journey? = nil
    
    @State var showSheet = false
    @State var addSheet = false
    
    var body: some View {
        VStack{
            NavigationSplitView {
                FolderListView(selectedFolder: $selectedFolder)
            } content: {
                
                if let folder = selectedFolder {
                    JourneyListView(for: folder, selectedJourney: $selectedJourney)
                } else {
                    Text("Placeholder")
                }
                
            } detail: {
                if let journey = selectedJourney {
                    CreateView(journey: journey)
                } else {
                    Text("Placeholder")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
