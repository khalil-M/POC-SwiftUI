//
//  NavigationButton.swift
//  POC-SwiftUI
//
//  Created by User on 07/07/2024.
//

import SwiftUI

struct NavigationButton: View {
    
    @State var lineWidth: CGFloat = 0
    @State var smallerLineWidth: CGFloat = 0
    
    let color: Color
    let buttonAction: () -> ()
    
    var body: some View {
        ZStack {
            Button(action: {
                
            })
            {
                VStack(alignment: .leading) {
                    Capsule(style: .continuous)
                        .frame(width: lineWidth, height: 3)
                    Capsule(style: .continuous)
                        .frame(width:  smallerLineWidth, height: 3)
                }
            }
            .foregroundColor(color)
            .onAppear() {
                withAnimation(Animation.easeOut(duration: 0.5)) {
                    self.lineWidth = 40
                }
                
                Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                    withAnimation(Animation.easeOut(duration: 0.35)) {
                        self.smallerLineWidth = 18
                    }
                }
            }
        }.frame(width: 44, height: 44, alignment: .leading)
        
    }
}

#Preview {
    NavigationButton(color: .black, buttonAction: { })
}


/*

         
         Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
             withAnimation(Animation.easeOut(duration: 0.35)) {
                 self.smallerLineWidth = 18
             }
         }
     }
 }
 */
