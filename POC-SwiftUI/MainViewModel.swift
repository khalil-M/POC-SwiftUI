//
//  MainViewModel.swift
//  POC-SwiftUI
//
//  Created by User on 07/07/2024.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    
    // MARK: -  Variables
    @Published var user: User = User(name: "Shubham Singh")
    
    
    @Published var searchText = "" {
        didSet {
//            guard !searchText.isEmpty else { return }
            
            searchPinnedNotes()
            searchNotes()
        }
    }
    
    @Published var pinnedNotes: [Note] = [
        Note(id: 24, title: "Code Snippets", category: "iOS Dev", description: "Commonly used Snippets for Playground and Extensions", lastUpdated: "16 April 2023", location: "Bengaluru, KA", tags: ["Code"], logo: "iphone"),
        Note(id: 12, title: "To Learn", category: "iOS Dev", description: "List of contents that you need to check out to get better in iOS development.", lastUpdated: "16 April 2023", location: "Bengaluru, KA", tags: ["Links", "Learning", "Articles"], logo: "iphone"),
        Note(id: 21, title: "App Ideas", category: "Self", description: "Ideas for app development / small projects, and experiments", lastUpdated: "16 April 2023", location: "Bengaluru, KA", tags: ["Ideas", "Self"], logo: "lightbulb.fill"),
    ]
    
    @Published var notes: [Note] = [
        Note(id: 46, title: "Design Tips", category: "Design", description: "Common UI / UX pitfalls and tips for improving the applications I develop", lastUpdated: "16 April 2023", location: "Bengaluru, KA", tags: ["Tips", "Learning"], logo: "lasso"),
        Note(id: 49, title: "Async-Await", category: "Structured concurrency with async-await method calls makes it easier to reason", description: "", lastUpdated: "15 April 2023", location: "Bengaluru, KA", tags: ["Tips", "Learning"], logo: "lasso"),
        Note(id: 406, title: "App Plan", category: "Planning", description: "Plan for implementing the tasks and milestones for .Dev", lastUpdated: "14 April 2023", location: "Bilaspur, CG", tags: ["Work"], logo: "calander"),
        Note(id: 45, title: "iOS Architecture", category: "iOS Dev", description: "Learnings and thoughts on using a particular iOS Architecture", lastUpdated: "14 April 2023", location: "Bengaluru, KA", tags: ["Ideas", "Thoughts"], logo: "lightbulb.fill"),
        Note(id: 51, title: "//", category: "Design", description: """
             switch result {
             case .success(let images):
                 print("Fetched images.")
             case .failure(let error):
""", lastUpdated: "06 April 2022", location: "Bengaluru, KA", tags: ["Tips", "Learning"], logo: "lasso"),
        Note(id: 406, title: "Animations", category: "iOS Dev", description: "Plan for implementing the tasks and milestones for ", lastUpdated: "09 April 2023", location: "Bilaspur, CG", tags: ["Learning", "Code"], logo: "calander")
    ]
    
    @Published var displayPinnedNotes: [Note] = []
    @Published var displayNotes: [Note] = []
    
    @Published var filteredPinnedNotes: [Note] = []
    @Published var filterredNotes: [Note] = []
    
    @Published var filtersActive = false
    
    
    // MARK: - inits
    init() {
        self.displayPinnedNotes = self.pinnedNotes
        self.displayNotes = self.notes
    }
    
    
    
    // MARK: - functions
    func searchPinnedNotes() {
        let notes = filtersActive ? filteredPinnedNotes : pinnedNotes
        
        withAnimation(Animation.easeInOut(duration: 0.35)) {
            self.displayPinnedNotes = notes.filter({ pinnedNote in
                pinnedNote.title.lowercased().starts(with: self.searchText.lowercased())
            })
        }
        
        print("after search", self.displayPinnedNotes,self.searchText)
    }
    
    
    func searchNotes() {
        let notes = filtersActive ? filterredNotes : notes

        withAnimation(Animation.easeInOut(duration: 0.35)) {
            self.displayNotes = notes.filter({ note in
                note.title.lowercased().starts(with: self.searchText.lowercased())
            })
        }
    }
    
    func filterWithFilters(filters: [Filter]) {
        guard !filters.isEmpty else {
            filtersActive = false
            
            withAnimation(.easeInOut(duration: 0.25)) {
                self.displayNotes = self.notes
                self.displayPinnedNotes = self.pinnedNotes
            }
            
            return
        }
        
        filtersActive = true
        
        var pinned = self.pinnedNotes
        var notes = self.notes
        
        for filter in filters {
            switch filter.filterType {
            case .category:
                pinned = pinned.filter({ note in
                    note.category.lowercased() == filter.name.lowercased()
                })
                
                notes = notes.filter({ note in
                    note.category.lowercased() == filter.name.lowercased()
                })
                
            case .tag:
                pinned = pinned.filter({ note in
                    note.tags.contains(filter.name)
                })
                
                notes = notes.filter({ note in
                    note.tags.contains(filter.name)
                })
            default:
                break
            }
        }
        
        self.filteredPinnedNotes = pinned
        self.filterredNotes = notes
        
        
        withAnimation(.easeInOut(duration: 0.25)) {
            self.displayPinnedNotes = filteredPinnedNotes
            self.displayNotes = filterredNotes
        }
    }
    
    func reset() {
        self.searchText = ""
        self.displayPinnedNotes = pinnedNotes
        self.displayNotes = notes
    }
}


struct Note: Identifiable, Hashable {
    let id: Int
    let title: String
    let category: String
    let description: String
    let lastUpdated: String
    let location: String
    let tags: [String]
    let logo: String
    
    var isPinned: Bool = false
}


struct User {
    let name: String
    let firstName: String
    let lastName: String
    
    init(name: String) {
        self.name = name
        self.firstName = name.components(separatedBy: " ")[0]
        self.lastName = name.components(separatedBy: " ")[1]
    }
}


enum FilterType {
    case category
    case location
    case tag
    case date
}

struct Filter: Hashable {
    let name: String
    let filterType: FilterType
}


struct FilterGroup: Identifiable {
    let id: Int
    let groupName: String
    let filters: [Filter]
}
