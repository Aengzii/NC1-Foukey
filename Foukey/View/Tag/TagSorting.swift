//
//  TagSorting.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import Foundation

enum TagSorting: String, Identifiable, CaseIterable {
    case aToZ
    case ztoA
    case latest
    case oldest
    
    var title: String {
        switch self {
            case .aToZ:
                return "오름차순"
            case .ztoA:
                return "내림차순"
            case .latest:
                return "최근순"
            case .oldest:
                return "오래된순"
        }
    }
    
    var sortDescriptor: SortDescriptor<Tag> {
        switch self {
            case .aToZ:
                SortDescriptor(\Tag.name, order: .forward)
            case .ztoA:
                SortDescriptor(\Tag.name, order: .reverse)
            case .latest:
                SortDescriptor(\Tag.creationDate, order: .reverse)
            case .oldest:
                SortDescriptor(\Tag.creationDate, order: .forward)
        }
       
    }
    
    var id: Self { return self }
}


