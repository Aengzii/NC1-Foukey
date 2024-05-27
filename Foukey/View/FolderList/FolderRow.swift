//
//  FolderRow.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

struct FolderRow: View {
    var folder: Folder
    let selectedFolder: Folder?
    
    @FocusState private var textFieldIsSelected: Bool
    @State private var showRenameEditor: Bool = false
    
    var folderColor: Color {
        selectedFolder == folder ? Color.white : Color.accentColor
    }
    
    var body: some View {
        HStack {
#if os(iOS)
            Label(folder.name, systemImage: "folder")
                
                .badge(folder.journeys.count)
            
#else
            Image(systemName: "folder")
               // .foregroundColor(.green)
                //.foregroundStyle(folderColor)
            TextField("name", text: $folder.name)
                .focused($textFieldIsSelected)
            Spacer()
            Text("\(folder.journeys.count)")
                .foregroundColor(.secondary)
#endif

        }
        .swipeActions {
            
            Button(role: .destructive) {
                Folder.delete(folder)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            Button(action: {
                startRenameAction()
            }, label: {
                Label("Rename", systemImage: "pencil")
            })
            
        }
        .contextMenu {
            
            Button("Rename") {
                startRenameAction()
            }
            Button("Delete") {
                Folder.delete(folder)
            }
        }
        .sheet(isPresented: $showRenameEditor, content: {
            FolderEditorView(folder: folder)
                .presentationDetents([.height(200)])
                .presentationCornerRadius(15)
        })
        

    }
    
    func startRenameAction() {
        #if os(OSX)
        textFieldIsSelected = true
        #else
        showRenameEditor = true
        #endif
    }
}

#Preview {
    ModelPreview { folder in
        FolderRow(folder: folder, selectedFolder: nil)
            .padding()
    }
}


