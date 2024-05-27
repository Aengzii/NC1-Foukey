//
//  CalendarView.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import Foundation
import SwiftUI

struct CalendarView: View{
    @State private var date = Date()
    var body: some View{
        VStack{
            DatePicker(
            "Calendar",
            selection: $date,
            displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .tint(.blue)
        }
    }
}

#Preview {
    CalendarView()
}


