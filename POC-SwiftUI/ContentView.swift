//
//  ContentView.swift
//  POC-SwiftUI
//
//  Created by User on 07/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var mainViewModel: MainViewModel = MainViewModel()
    @StateObject var filterViewModel: FilterViewModel = FilterViewModel()
    
    @State var viewAppeared = false
    
    @State var viewReady = false
    @State var filtersOpened = false
    
    var body: some View {
        
        GeometryReader { proxy in
            
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            NavigationButton(color: .black) { }
                            Spacer()
                            ImageView(size: 60)
                                .shadowOverlay(xOffset: 5, yOffset: 7, lineWidth: 2, opacity: colorScheme == .dark ? Constants.darkOpacity : 1, colorScheme: colorScheme, content: Circle())
                                .padding(.trailing, 12)
                                .frame(width: 68, height: 68)
                        }
                        
                        Text("Hey Apimo,")
                            .font(TypefaceTwo.semibold.font(size: 32))
                            .tracking(-0.2)
                            .offset(y: viewReady ? 0 : 12)
                            .opacity(viewReady ? 1 : 0.3)
                            .animation(.easeInOut(duration: 0.2).delay(0.05), value: viewReady)
                        
                        HStack {
                            SearchView()
                                .environmentObject(mainViewModel)
                                .padding(.trailing, 6)
                            
                            Spacer()
                            
                            FilterButton(filtersOpened: $filtersOpened)
                                .environmentObject(filterViewModel)
                        }
                            
                            FilterButton(filtersOpened: $filtersOpened)
                                .environmentObject(filterViewModel)
//                        }
                        .padding(.top, 12)
                        .opacity(viewAppeared ? 1 : 0)
                        .animation(.easeInOut(duration: 0.3), value: viewAppeared)
                    }
                    .padding(24)
                }
            } .onAppear() {
                self.viewReady = true
            }
        }
    }
}

#Preview {
    ContentView()
}
/*

    
    
    PinnedNotesView(viewAppeared: $viewReady, width: width)
        .environmentObject(mainViewModel)
        .opacity(self.mainViewModel.displayPinnedNotes.isEmpty ? 0 : 1)
        .animation(.default, value: self.mainViewModel.displayPinnedNotes)
        .offset(y: self.mainViewModel.displayPinnedNotes.isEmpty ? -48 : 0)
        .animation(.interactiveSpring(response: 0.2), value: self.mainViewModel.displayPinnedNotes)
        .padding(.top, 16)

    RecentNotesView(viewAppeared: $viewAppeared, height: height, colorScheme: colorScheme)
        .environmentObject(mainViewModel)
        .padding(.top, 8)
        .opacity(self.mainViewModel.displayNotes.isEmpty ? 0 : 1)
        .offset(y: mainViewModel.displayPinnedNotes.isEmpty ? -215 / 2.25 : .zero)
        .animation(.easeInOut(duration: 0.3), value: self.mainViewModel.displayPinnedNotes)
}
*/



enum TypefaceOne {
    case regular
    
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("BungeeLayers-Regular", size: size)
        }
    }
}

enum TypefaceTwo {
    case regular
    case medium
    case semibold
    case bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("Degular-Regular", size: size)
        case .medium:
            return .custom("Degular-Medium", size: size)
        case .semibold:
            return .custom("Degular-SemiBold", size: size)
        case .bold:
            return .custom("Degular-Bold", size: size)
            
        }
    }
}
