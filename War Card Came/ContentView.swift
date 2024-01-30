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
                    .padding(.top, 5)
                
                //logo and score
                HStack {
                    Spacer()
                    VStack {
                        Text("USR")
                            .padding(.bottom, 2)
                            .underline()
                        Text(String(self.userData.playerScore))
                    }
                    Spacer()
                    Image("logo")
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
                
                
                //cards
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                
                
                //deal button and winner
                VStack {
                    Spacer().frame(height: 10)
                    Button {
                        deal()
                    } label: {
                        Image("button")
                    }
                    Text(winner)
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .fontWeight(.bold)
                     
                    
                    Spacer().frame(height: 15)
                }
                VStack {
                    HStack {
                        Text("Current Bet:")
                        Text("$" + String(self.userData.bet)).foregroundColor(.red)
                    }
                    
                    Text("Your Money: $" + String(self.userData.myMoney))
                    
                }
                .font(.title3)
                .padding(18)
                .foregroundColor(.yellow)
                .background(Rectangle().foregroundColor(.black).opacity(0.3).cornerRadius(9))
                
                Spacer().frame(height: 60)
                HStack {
                    
                    BettingButton(buttonTitle: "$1", action: {addBet(1)})
                    BettingButton(buttonTitle: "$10", action: {addBet(10)})
                    BettingButton(buttonTitle: "$20", action: {addBet(20)})
                    BettingButton(buttonTitle: "$100", action: {addBet(100)})
                    
                }
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
    
    
    
    //main game engine to handle logic then passes of the results to user data
    func deal() {
        if !winner.isEmpty {
            winner = ""
        }
        
        let pCard = Int.random(in: 2...14)
        let cCard = Int.random(in: 2...14)
        playerCard = "card" + String(pCard)
        cpuCard = "card" + String(cCard)
        
        //player has won
        if(pCard > cCard) {
            self.userData.incrementPlayerScore()
            winner = "Player 1 wins!"
            runningStreak = true
            self.userData.playerWon()
        
        //player loses
        } else if(cCard > pCard){
            self.userData.incrementCpuScore()
            winner = "CPU Wins!"
            runningStreak = false
            
            
         //draw between cpu and player
        } else {
            winner = "Its a Draw!"
            self.userData.handleDraw()
        }
        
        self.userData.prepareNextHand()
        userData.calculateSteak(runningStreak)
    }
    
     
    
    func addBet(_ num: Int) {
        self.userData.addBet(num)
    }
}

struct BettingButton: View {
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        Button(buttonTitle, action: action)
            .font(.system(.title3, design: .rounded))
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .frame(maxWidth: 80)
            .background(.yellow)
            .foregroundColor(.black)
            .clipShape(Capsule())
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
