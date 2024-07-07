//
//  ImageView.swift
//  POC-SwiftUI
//
//  Created by User on 07/07/2024.
//

import SwiftUI


struct ImageView: View {
    
    // MARK: - Variables
    
    var imageName: String = "thumb"
    var size: CGFloat = 80
    
    var needsAnimation: Bool = true
    
    // MARK: - Views
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .scaleEffect(1.4, anchor: .top)
                .clipShape(Circle())
                .frame(width: size, height: size)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(needsAnimation: false)
    }
}
