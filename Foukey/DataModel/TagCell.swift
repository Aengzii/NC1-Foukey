//
//  TagCell.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI

struct TagCell: View {
    let tag: Tag
    var body: some View {
        HStack {
            Image(systemName: "tag.fill")
                .foregroundColor(tag.color)
                .shadow(color: Color(white: 0.8), radius: 2, x: 1, y: 0)
                
            Text(tag.name)
        }
        .padding(5)
        
        .background(
            ZStack {
                Capsule().fill(Color.white)
                Capsule().stroke(tag.color)
            }
        )
    }
}

#Preview {
    ModelPreview { tag in
        TagCell(tag: tag)
    }
}



