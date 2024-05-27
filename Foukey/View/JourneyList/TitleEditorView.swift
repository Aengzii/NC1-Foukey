//
//  TitleEditorView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

struct TitleEditorView: View {
    
    @Environment(\.dismiss) var dismiss
    let journey: Journey
    
    @State private var title: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("기존 파일명: \(journey.title)")
                .font(.title2)
                .bold()
            
            TextField("Journey Name", text: $title)
                .textFieldStyle(.roundedBorder)
                .focused($isFocused)
            
            HStack {
                Button("취소") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                
                Button("변경") {
                    journey.title = title
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
               
            }
        }
        .padding()
        .onAppear {
           title = journey.title
            isFocused = true
        }
        
    }
}

private struct PreviewTitleEditorView: View {
    @Query(sort: \Journey.creationDate, order: .forward)
    private var journeys: [Journey]
    var body: some View {
        TitleEditorView(journey: journeys[0])
    }
}

struct TitleEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewTitleEditorView()
            .modelContainer(PreviewSampleData.container)
    }
}

