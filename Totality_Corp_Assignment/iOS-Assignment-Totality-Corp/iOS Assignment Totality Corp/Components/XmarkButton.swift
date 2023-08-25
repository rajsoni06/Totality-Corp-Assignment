//
//  XmarkButton.swift
//  iOS Assignment Totality Corp
//
//  Created by Nishay Kumar on 10/08/23.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var animate = false
    
    var body: some View {
        Button(action: {
            // Close the current view when this code is called.
            // Useful for dismissing a modal view.
            presentationMode.wrappedValue.dismiss()
        }, label: {
            ZStack {
                Capsule()
                    .frame(width: 20, height: 2)
                    .rotationEffect(Angle(degrees: -45))
                    .offset(y: animate ? 0 : 10)
                    .opacity(animate ? 1 : 1)
                    .animation(Animation.easeInOut(duration: 0.4).delay(0.2), value: animate)
                
                Capsule()
                    .frame(width: 20, height: 2)
                    .rotationEffect(Angle(degrees: 45))
                    .opacity(animate ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 0.4).delay(0.4), value: animate)
            }
            .font(.headline)
            .foregroundColor(.theme.black)
            .onAppear {
                animate = true
            }
        })
    }
}


struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
    }
}
