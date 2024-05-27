//
//  JourneyRow.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI

struct JourneyRow: View {
    let journey: Journey
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("☘️")
                Text(journey.title)
                
                Spacer()
            }
            
            Text(journey.creationDate, format: .dateTime)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ModelPreview { journey in
        NavigationStack {
            JourneyRow(journey: journey)
        }
    }
}

