//
//  PreviewDataModel.swift
//  Foukey
//
//  Created by Lee YunJi on 4/23/24.
//

import SwiftData
import SwiftUI

/**
 Preview sample data. from demo project Backyard Birds
 */
actor PreviewSampleData {
    @MainActor
    static var container: ModelContainer = {
        let schema = Schema([Folder.self, Journey.self, Tag.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        let sampleData: [any PersistentModel] = [
            Journey.example2(), Folder.exampleWithSnippets()
        ]
        sampleData.forEach {
            container.mainContext.insert($0)
        }
        return container
    }()
    
    
    @MainActor
    static var emptyTestContext: ModelContext = {
        let schema = Schema([Folder.self, Journey.self, Tag.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        return container.mainContext
    }()
}

// add all data here that you want to use with the previews:
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Journey.self,
                                           configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        Task { @MainActor in
            
            let context = container.mainContext
            
            let snip = Journey.example2()
            
            context.insert(snip)
            context.insert(Journey.example3())
            context.insert(Journey.example4())
    
            let folderOne = Folder.exampleWithSnippets()
            context.insert(folderOne)
            
            let tag = Tag.example()
            tag.journeys.append(snip)
            
            
            context.insert(Tag.example2())
            context.insert(Tag.example3())
            
            let folder = Folder(name: "folder with favorite journey")
            context.insert(folder)
            
            let emptyFolder = Folder(name: "empty folder")
            context.insert(emptyFolder)
        }
        
        return container
    } catch {
        fatalError("Failed to create container: \(error.localizedDescription)")
    }
}()

