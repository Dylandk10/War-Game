//
//  GameBreak.swift
//  War Card Came
//
//  Created by Dylan Kelly on 1/31/24.
//

import SwiftUI

struct GameBreak: View {
    @ObservedObject var quoteHandler = QuoteHandler()
    init(quoteHandler: QuoteHandler = QuoteHandler()) {
        self.quoteHandler = quoteHandler
    }
    var body: some View {
        ZStack {
            Image("wintery-sunburst")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Favorite Quotes!")
                    .font(.title)
                CarouselCard()
                    
                MainInfoCard(quoteHandler: self.quoteHandler)
                
                Spacer()
                QuoteButtonAction(buttonTitle: "Get Quote", action: {quoteHandler.setNewQuote()})
                    .padding()
            }
        }
    }
}

struct MainInfoCard : View {
    @ObservedObject var quoteHandler: QuoteHandler
    var body: some View {
        VStack {
            Text(quoteHandler.singleQuote.name)
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
            Text(quoteHandler.singleQuote.quote)
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




