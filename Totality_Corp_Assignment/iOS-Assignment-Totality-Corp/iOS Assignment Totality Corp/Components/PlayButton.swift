//
//  PlayButton.swift
//  iOS Assignment Totality Corp
//
//  Created by Raj Anand Soni on 24/08/23.
//

import SwiftUI

struct PlayButton: View {
    @State var text: String
    @State var fillColor: Color
    var body: some View {
        ZStack {
            HStack {
                Capsule()
                    .fill(fillColor)
                // Set the width of the Capsule to the screen width minus 30
                    .frame(width: UIScreen.main.bounds.width - 30, height: 70)
                
            }
            Text(text)
                .foregroundColor(.white)
        }
        .padding(.horizontal)
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(text: "Play", fillColor: Color.theme.blue)
    }
}
