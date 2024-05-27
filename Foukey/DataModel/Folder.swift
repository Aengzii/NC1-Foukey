//
//  Folder.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import Foundation
import SwiftData


@Model final public class Folder {
    
    @Attribute(originalName: "creationDate_")
    var creationDate: Date
    
    @Attribute(originalName: "name_")
    var name: String
    
    @Attribute(originalName: "uuid_")
    var uuid: UUID
    
    // array - but data is not keeping sort order
    @Relationship(deleteRule: .cascade, inverse: \Journey.folder) var journeys: [Journey]
  
    //MARK: - Init
    
    init(name: String = "",
         journeys: [Journey] = []) {
        self.creationDate = Date()
        self.uuid = UUID()
        
        self.name = name
        self.journeys = journeys
    }

    static func delete(_ folder: Folder) {
        if let context = folder.modelContext {
            context.delete(folder)
        }
    }
    
    static func example() -> Folder {
        return Folder(name: "test folder")
    }
    
    static func exampleWithSnippets() -> Folder {
        let folder = Folder(name: "test folder")
        folder.journeys.append(Journey.example())
        return folder
    }
}
