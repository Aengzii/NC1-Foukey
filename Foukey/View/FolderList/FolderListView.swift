//
//  FolderListView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

struct FolderListView: View {
    
    @Environment(\.modelContext) private var context

    @Query(sort: \Folder.creationDate, order: .forward)
    var folders: [Folder]

    @Binding var selectedFolder: Folder?
   
    
    var body: some View {
        VStack{
            HCalendarView()
            
            Spacer()
            
            List(selection: $selectedFolder) {
                ForEach(folders) { folder in
                    NavigationLink(value: folder) {
                        FolderRow(folder: folder, selectedFolder: selectedFolder)
                    }
                }
                .onDelete(perform: deleteItems)
            }
           // .navigationTitle("앵지의 기록")
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addFolder) {
                        Label("Add Folder", systemImage: "folder.badge.plus")
                    }
                }
            }
        }
    }
    
    private func addFolder() {
        withAnimation {
            let folder = Folder(name: "new folder")
            context.insert(folder)
            selectedFolder = folder
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            
            offsets.map { folders[$0] }.forEach { context.delete($0) }

        }
    }
}



#Preview {
    MainActor.assumeIsolated {
        NavigationView {
            FolderListView(selectedFolder: .constant(nil))
        }
        .modelContainer(PreviewSampleData.container)
    }
}

