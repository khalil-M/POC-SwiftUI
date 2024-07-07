//
//  FilterViewModel.swift
//  POC-SwiftUI
//
//  Created by User on 07/07/2024.
//


import SwiftUI

class FilterViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var filters: [FilterGroup] = [
        FilterGroup(id: 12, groupName: "Category", filters: [
            Filter(name: "iOS Dev", filterType: .category),
            Filter(name: "Design & Tips", filterType: .category),
            Filter(name: "Self Notes", filterType: .category),
            Filter(name: "Planning", filterType: .category)
        ]),
        FilterGroup(id: 42, groupName: "Location", filters: [
            Filter(name: "Bengaluru", filterType: .location),
            Filter(name: "Bilaspur", filterType: .location),
            Filter(name: "Delhi", filterType: .location),
        ]),
        FilterGroup(id: 122, groupName: "Tags", filters: [
            Filter(name: "Ideas", filterType: .tag ),
            Filter(name: "Tips", filterType: .tag),
            Filter(name: "Learning", filterType: .tag),
            Filter(name: "Thoughts", filterType: .tag),
            Filter(name: "Work", filterType: .tag),

        ]),
        FilterGroup(id: 62, groupName: "Date", filters: [
            Filter(name: "16 April 2023", filterType: .date),
            Filter(name: "12 April 2023", filterType: .date),
            Filter(name: "14 April 2023", filterType: .date),
            Filter(name: "15 April 2023", filterType: .date),
            Filter(name: "Show more", filterType: .date),

        ])
    ]
    
    @Published var selectedIndex = 0
    
    @Published var filterOpened = false {
        didSet {
            print("Val check", filterOpened)
        }
    }
    
    @Published var filterGroupOpened = false
    
    @Published var addedFilters: [Filter] = []
    @Published var addedGroups: [Int : Int] = [:]

    
    // MARK: - inits
    init() {
        for filterGroup in filters {
            self.addedGroups[filterGroup.id] = 0
        }
    }
    
    
    // MARK: - Functions
    func addFilters(filter: Filter, groupID: Int) {
        
        if (self.addedGroups[groupID] != nil) {
            self.addedGroups[groupID]! += 1
        } else {
            self.addedGroups[groupID] = 1
        }
        
        self.addedFilters.append(filter)
    }
    
    func removeFilters(filter: Filter, groupID: Int) {
        if (self.addedGroups[groupID] == 1) {
            self.addedGroups[groupID] = 0
        } else {
            self.addedGroups[groupID]! -= 1
        }
        withAnimation(.default) {
            self.addedFilters = addedFilters.filter({$0 != filter})
        }
    }
    
    func addOrRemoveFilter(filter: Filter, groupID: Int) {
        if (!self.addedFilters.contains(filter)) {
            addFilters(filter: filter, groupID: groupID)
        } else {
            removeFilters(filter: filter, groupID: groupID)
        }
    }
    
    func clearFilters() {
        withAnimation(.default) {
            self.addedFilters = []
            self.addedGroups = [:]
        }
    }
    
    func checkIfTagsAreSelectedForGroup(filterID: Int) -> Int {
        return self.addedGroups[filterID] ?? 0
    }
}
