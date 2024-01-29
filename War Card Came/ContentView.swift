//
//  ContentView.swift
//  War Card Came
//
//  Created by Dylan Kelly on 1/26/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userData = UserData.shared
    
    
    @State var runningStreak = true
    
    @State var playerCard = "back"
    @State var cpuCard = "back"
    
    @State var winner = "Let's Deal!"
    
    
    var body: some View {
        ZStack{
            Image("background-plain")
            VStack{
                Spacer()
                Text("Longest streak: " + String(userData.longestStreak))
                    .font(.title3)
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                Image("logo").padding(.top, 15)
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                Spacer().frame(height: 39)
                
                Button {
                    deal()
                } label: {
                    Image("button")
                }
                Text(winner)
                    .font(.title3)
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
                
                
                Spacer().frame(height: 15)
                HStack {
                    Spacer()
                    VStack {
                        Text("PLAYER")
                            .padding(.bottom, 2)
                            .underline()
                        Text(String(self.userData.playerScore))
                    }
                    Spacer()
                    VStack {
                        Text("CPU")
                            .padding(.bottom, 2)
                            .underline()
                        Text(String(self.userData.cpuScore))
                    }
                    
                    Spacer()
                }
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 15)
                Spacer()
                
            }
            
            
            
        //holds the application is portrait mode and when screen is not active removes the hold
        }.onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
            AppDelegate.orientationLock = .portrait // And making sure it stays that way
        }.onDisappear {
            AppDelegate.orientationLock = .all // Unlocking the rotation when leaving the view
        }
        
    }
    
    
    
    //deal cards
    func deal() {
        if !winner.isEmpty {
            winner = ""
        }
        
        let pCard = Int.random(in: 2...14)
        let cCard = Int.random(in: 2...14)
        playerCard = "card" + String(pCard)
        cpuCard = "card" + String(cCard)
        
        if(pCard > cCard) {
            self.userData.incrementPlayerScore()
            winner = "Player 1 wins!"
            runningStreak = true
        } else if(cCard > pCard){
            self.userData.incrementCpuScore()
            winner = "CPU Wins!"
            runningStreak = false
        } else {
            winner = "Its a Draw!"
        }
        
        userData.calculateSteak(runningStreak)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
