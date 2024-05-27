//
//  Tag.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftUI
import SwiftData

@Model final public class Tag {
    
    @Attribute(originalName: "uuid_")
    var uuid: UUID
    
    @Attribute(originalName: "creationDate_")
    var creationDate: Date
    
    @Attribute(originalName: "name_")
    var name: String
    
    
    var journeys: [Journey]
    
    var colorData: ColorData
    var color: Color {
        get { colorData.color }
        set { colorData = ColorData(color: newValue)}
    }
    
    //MARK: - Init
    
    init(
        color: Color = Color.black,
        name: String = "",
        journeys: [Journey] = []
    ) {
        self.creationDate = Date()
        self.uuid = UUID()
        self.colorData = ColorData(color: color)
        self.name = name
        self.journeys = journeys
    }
    
    static func delete(_ tag: Tag) {
        if let context = tag.modelContext {
            context.delete(tag)
        }
    }
    
    static func example() -> Tag {
        Tag(color: Color(red: 1, green: 0, blue: 1), name: "꽃놀이")
    }
    
    static func example2() -> Tag {
        Tag(color: Color(red: 1, green: 1, blue: 0), name: "안녕하세요")
    }
    
    static func example3() -> Tag {
        Tag(color: Color(red: 1, green: 0, blue: 0), name: "앵지예요")
    }
}


