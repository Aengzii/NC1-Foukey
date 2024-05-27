//
//  FolderEditorView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

struct FolderEditorView: View {
    
    @Environment(\.dismiss) var dismiss
    let folder: Folder
    
    @State private var name: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("기존 폴더명: \(folder.name)")
                .font(.title2)
                .bold()
            
            TextField("Folder Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .focused($isFocused)
            
            HStack {
                Button("취소") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                
                Button("변경") {
                    folder.name = name
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
               
            }
        }
        .padding()
        .onAppear {
           name = folder.name
            isFocused = true
        }
        
    }
}

private struct PreviewFolderEditorView: View {
    @Query(sort: \Folder.creationDate, order: .forward)
    private var folders: [Folder]
    var body: some View {
        FolderEditorView(folder: folders[0])
    }
}

struct FolderEditorView_Previews: PreviewProvider {
    static var previews: some View {
      //  FolderEditorView(folder: Folder.example())
        PreviewFolderEditorView()
            .modelContainer(PreviewSampleData.container)
    }
}



