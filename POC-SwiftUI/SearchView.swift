//
//  SearchView.swift
//  POC-SwiftUI
//
//  Created by User on 07/07/2024.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: - Variables
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.clear)
            .overlay(
                HStack(spacing: 14) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.label)
                        .font(.system(size: 25, weight: .semibold))
                        .opacity(0.85)
                    ZStack(alignment: .leading) {
                        Text("Search you luxery")
                            .font(TypefaceTwo.medium.font(size: 22))
                            .opacity(self.mainViewModel.searchText.isEmpty ? 0.3 : 0)
                            .animation(.default, value: mainViewModel.searchText)
                        TextField("", text: $mainViewModel.searchText, onEditingChanged: { val in
                        }, onCommit: {
                            if (!mainViewModel.searchText.isEmpty) {
                                self.mainViewModel.searchPinnedNotes()
                            }
                        })
                        .font(TypefaceTwo.semibold.font(size: 22))
                        .tracking(1.15)
                        .disableAutocorrection(true)
                        .padding(.vertical)
                        .accentColor(.label)
                        
                        HStack {
                            Spacer()
                            Image(systemName: "multiply")
                                .opacity(0.7)
                                .font(.system(size: 22, weight: .semibold))
                                .opacity(self.mainViewModel.searchText.count >= 1 ? 1 : 0)
                                .animation(.default, value: self.mainViewModel.searchText)
                                .onTapGesture {
                                    self.mainViewModel.reset()
                                }
                        }
                        
                    }
                    Spacer()
                }
                    .padding()
            )
            .shadowOverlay(xOffset: 5, yOffset: 7, lineWidth: 3, opacity: 1, colorScheme: colorScheme, content: RoundedRectangle(cornerRadius: 12))
            .frame(height: 58)
    }
}

#Preview {
    SearchView()
}

/*
 {
     RoundedRectangle(cornerRadius: 20)
         .foregroundColor(.clear)
         .overlay(
             
                 ZStack(alignment: .leading) {
                     Text("Search your notes")
                         .font(TypefaceTwo.medium.font(size: 22))
                         .tracking(1.1)
                         .opacity(self.mainViewModel.searchText.isEmpty ? 0.3 : 0)
                         .animation(.default, value: mainViewModel.searchText)
                     TextField("", text: $mainViewModel.searchText, onEditingChanged: { val in
                     }, onCommit: {
                         if (!mainViewModel.searchText.isEmpty) {
                             self.mainViewModel.searchPinnedNotes()
                         }
                     })
                     .font(TypefaceTwo.semibold.font(size: 22))
                     .tracking(1.15)
                     .disableAutocorrection(true)
                     .padding(.vertical)
                     .accentColor(.label)
                     
                     HStack {
                         Spacer()
                         Image(systemName: "multiply")
                             .opacity(0.7)
                             .font(.system(size: 22, weight: .semibold))
                             .opacity(self.mainViewModel.searchText.count >= 1 ? 1 : 0)
                             .animation(.default, value: self.mainViewModel.searchText)
                             .onTapGesture {
                                 self.mainViewModel.reset()
                             }
                     }
                 }
                 
                 Spacer()
             }
             .padding()
         )
         .shadowOverlay(xOffset: 5, yOffset: 7, lineWidth: 3, opacity: 1, colorScheme: colorScheme, content: RoundedRectangle(cornerRadius: 12))
         .frame(height: 58)
 }
 */
