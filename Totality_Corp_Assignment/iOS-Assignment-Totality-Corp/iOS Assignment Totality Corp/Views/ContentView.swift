//
//  ContentView.swift
//  iOS Assignment Totality Corp
//
//  Created by Raj Anand Soni on 24/08/23.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        //Utilizing NavigationStack for a smoother and more seamless navigation experienc
        NavigationStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    Text("PLAY")
                        .styledText(isBold: true)
                    NavigationLink {
                        SecondView()
                    } label: {
                        CardView()
                    }
                    Rectangle()
                        .fill(Color.theme.orange)
                        .frame(width: 350, height: 500)
                        .cornerRadius(30)
                }
            }
        }
    }
}


struct CardView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.theme.orange)
                .frame(width: 350, height: 500)
                .cornerRadius(30)
            
            VStack(alignment: .leading){
                Rectangle()
                    .fill(Color.theme.yellow)
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                    .overlay {
                        Image("char2")
                            .resizable()
                            .scaledToFit()
                    }
                
                Spacer()
                Capsule()
                    .fill(Color.theme.green)
                    .frame(width: 300, height: 70)
            }
            .padding(.vertical, 25)
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
