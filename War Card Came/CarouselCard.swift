//
//  CarouselCard.swift
//  War Card Came
//
//  Created by Dylan Kelly on 2/2/24.
//

import SwiftUI

struct CarouselCard: View {
    @ObservedObject var quotes = QuoteHandler()
    
        var body: some View {
            AutoScroller(quotes: quotes.quotes)
        }
    }
 
    
    // Step 2: Define the AutoScroller View
    struct AutoScroller: View {
        var quotes: [Quotes]
        
        // Step 3: Manage Selected Image Index
        @State private var selectedImageIndex: Int = 0
        
        var body: some View {
            ZStack {
                // Step 4: Background Color
                Color.secondary
                    .ignoresSafeArea()
                
                // Step 5: Create TabView for Carousel
                TabView(selection: $selectedImageIndex) {
                    // Step 6: Iterate Through Images
                    ForEach(0..<quotes.count, id: \.self) { index in
                        ZStack(alignment: .topLeading) {
                            // Step 7: Display Image
                            LargeInfoCard(titleContent: quotes[index].name, bodyContent: quotes[index].quote)
                                .tag(index)
                                .frame(width: 350, height: 200)
                        }
                        .shadow(radius: 20) // Step 9: Apply Shadow
                    }
                }
                .frame(height: 300) // Step 10: Set Carousel Height
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Step 11: Customize TabView Style
                .ignoresSafeArea()
                
                // Step 12: Navigation Dots
                HStack {
                    ForEach(0..<quotes.count, id: \.self) { index in
                        // Step 13: Create Navigation Dots
                        Capsule()
                            .fill(Color.white.opacity(selectedImageIndex == index ? 1 : 0.33))
                            .frame(width: 35, height: 8)
                            .onTapGesture {
                                // Step 14: Handle Navigation Dot Taps
                                selectedImageIndex = index
                            }
                    }
                    .offset(y: 130) // Step 15: Adjust Dots Position
                }
            }
        }
    }





struct LargeInfoCard : View {
    let titleContent: String
    let bodyContent: String
    var body: some View {
        VStack {
            
            HStack {
                Text(titleContent)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 7)
                Image(systemName: "message.fill")
                    .font(.system(size: 25))
                Image(systemName: "cloud.drizzle.fill")
                    .font(.system(size: 25))
                
            }
            Text(bodyContent)
            
        }
        .padding(20)
        
        .background(Rectangle().foregroundColor(.white).cornerRadius(15).shadow(color: .black, radius: 5, x: 2, y: 1))
        
    }
    
}

struct SmallInfoCard : View {
    let titleContent = "Name of Person"
    let bodyContent = "This is some body test to hold in place. This is where the quote will be"
    var body: some View {
        VStack {
            Text(titleContent)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 4)
                .multilineTextAlignment(.center)
            HStack {
                Image(systemName: "message.fill")
                    .font(.system(size: 15))
                Image(systemName: "cloud.drizzle.fill")
                    .font(.system(size: 15))
                
            }
            Text(bodyContent)
                .font(.subheadline)
        }
        .padding(20)
        
        .background(Rectangle().foregroundColor(.white).cornerRadius(15).shadow(color: .black, radius: 5, x: 2, y: 1))
        
    }
    
}

struct CarouselCard_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCard()
    }
}
