//
//  Journey.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//
import SwiftUI
import SwiftData



@Model final public class Journey {
    
    @Attribute(originalName: "uuid_")
    let uuid: UUID
    
    @Attribute(originalName: "creationDate_")
    let creationDate: Date
    
    @Attribute(originalName: "place_")
    var place: String
    
    @Attribute(originalName: "food_")
    var food: String
    
    @Attribute(originalName: "person_")
    var person: String
    
    @Attribute(originalName: "stuff_")
    var stuff: String

    @Attribute(.externalStorage)
    var image: Data?
    
    @Attribute(originalName: "notes_")
    var notes: String
    
    @Attribute(originalName: "title_")
    var title: String
    
    var folder: Folder?     // to-one relationships is always optional
  
    @Relationship(inverse: \Tag.journeys)
    var tags: [Tag] // relationships only works with optional
    

    //MARK: - Init
    
    init(
        place: String = "",
        food: String = "",
        person: String = "",
        stuff: String = "",
        notes: String = "",
        title: String = "",
        folder: Folder? = nil,
        tags: [Tag] = [],
        creationDate: Date = Date()
    ) {
        self.creationDate = creationDate
        self.uuid = UUID()
        self.place = place
        self.food = food
        self.person = person
        self.stuff = stuff
        self.notes = notes
        self.title = title
        
        self.folder = folder
        self.tags = tags
    }
    
    static func delete(_ journey: Journey) {
        if let context = journey.modelContext {
            context.delete(journey)
            //try? context.save() // suggested fix
        }
    }
    
    // MARK: - preview
    
    static var preview: Journey = {
        let journey = Journey(place: "test", title: "journey title")
        //Task { @MainActor in
        //    previewContainer.mainContext.insert(journey)
       // }
        return journey
    }()
    
    static func example() -> Journey {
        let journey = Journey(title: "My test journey")
        journey.place = "place"
        
      // this will crash the preview which does not work currently with relationships:
      //  snippet.tags.append(Tag.example())
      //  snippet.tags.append(Tag.example2())
      //  snippet.tags.append(Tag.example3())
        
        return journey
    }
    
    static func example2() -> Journey {
        let journey = Journey(title: "My Happy day")

        return journey
    }
    
    
    static func example3() -> Journey {
        let journey = Journey(title: "Old Journey", creationDate: Date() - 1000)

        return journey
    }
    
    static func example4() -> Journey {
        let journey = Journey(title: "journey from yesterday", creationDate: Date() - 100000)

        return journey
    }
}

extension Journey: Comparable {
    public static func < (lhs: Journey, rhs: Journey) -> Bool {
        lhs.creationDate < rhs.creationDate
    }
}
