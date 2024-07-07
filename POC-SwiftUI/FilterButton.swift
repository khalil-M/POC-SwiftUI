//
//  FilterButton.swift
//  POC-SwiftUI
//
//  Created by User on 07/07/2024.
//

import Foundation
import SwiftUI

struct FilterButton: View {
    
    // MARK: - Variables
    @Binding var filtersOpened: Bool
    @EnvironmentObject var filterViewModel: FilterViewModel
    
    
    // MARK: - Views
    var body: some View {
        Button(action : {
            
        }) {
            Image(systemName: "slider.horizontal.3")
                .font(.system(size: 28, weight: .semibold))
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.label)
                        .frame(width: 26, height: 26)
                        .overlay(
                            Text("\(filterViewModel.addedFilters.count)")
                                .foregroundColor(.background)
                                .font(TypefaceOne.regular.font(size: 16))
                        )
                        .offset(x: 12, y: -32)
                        .opacity(self.filterViewModel.addedFilters.count > 0 ? 1 : 0)
                        .animation(.default, value: self.filterViewModel.addedFilters)
                )
                .onTapGesture {
                    self.filtersOpened = true
                }
        }
        .frame(width: 54, height: 54)
        .buttonStyle(PlainButtonStyle())
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(filtersOpened: .constant(false))
            .environmentObject(FilterViewModel())
    }
}
