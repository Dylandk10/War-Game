//
//  GameBreak.swift
//  War Card Came
//
//  Created by Dylan Kelly on 1/31/24.
//

import SwiftUI

struct GameBreak: View {
    var body: some View {
        ZStack {
            Color(.gray)
                .ignoresSafeArea()
            VStack {
                CarouselCard()
                    
                MainInfoCard()
                
                Spacer()
                QuoteButtonAction(buttonTitle: "Get Quote", action: {})
                    .padding()
            }
        }
    }
}

struct MainInfoCard : View {
    let titleContent = "Name of Person"
    let bodyContent = "This is some body test to hold in place. This is where the quote will be"
    var body: some View {
        VStack {
            Text(titleContent)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 4)
                .multilineTextAlignment(.center)
            HStack {
                Image(systemName: "message.fill")
                    .font(.system(size: 25))
                Image(systemName: "cloud.drizzle.fill")
                    .font(.system(size: 25))
                
            }
            Text(bodyContent)
                .font(.system(size: 25))
        }
        .padding(20)
        
        .background(Rectangle().foregroundColor(.white).cornerRadius(15).shadow(color: .black, radius: 5, x: 2, y: 1))
        .padding(10)
        
    }
    
}


//this is for direct actions that need to do functionality and not navigate
struct QuoteButtonAction: View {
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        Button(buttonTitle, action: action)
            .font(.system(.title3, design: .rounded))
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .frame(maxWidth: .infinity)
            .background(.yellow)
            .foregroundColor(.black)
            .clipShape(Capsule())
    }
}

struct GameBreak_Previews: PreviewProvider {
    static var previews: some View {
        GameBreak()
    }
}




