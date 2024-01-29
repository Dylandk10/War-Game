//
//  MainMenu.swift
//  War Card Came
//
//  Created by Dylan Kelly on 1/27/24.
//

import SwiftUI

struct MainMenu: View {
    @ObservedObject var userData = UserData.shared
    @State var isPopUp = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("endless-constellation")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("Main Menu")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                        Spacer().frame(height: 45)
                        
                        //nav to contentview for war game
                        NavigationLink(destination: ContentView(), label: {
                            MenuButtonNavigation(buttonTitle: "Play Now")
                        })
                        
                        Spacer().frame(height: 25)
                        MenuButtonAction(buttonTitle: "Reset Longest Streak", action: {self.isPopUp = true})
                        Text("Created By Dylan Kelly")
                            .padding(.top, 50)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .alert(isPresented: self.$isPopUp, content: {
                        Alert(title: Text("Are you Sure?"),
                              message: Text("Do you want to reset your longest streak?"),
                              primaryButton: .destructive(Text("Reset")) {
                                resetLongestStreak()
                                },
                              secondaryButton: .cancel())
                    })
                    .padding(50)
                    
                    
                }
                .background(Rectangle().foregroundColor(.white).cornerRadius(15).padding(15).opacity(0.2))
                .padding(.bottom, 140)
            }
        }.accentColor(.yellow)
    }
    
    
    //probably not the best to create a new user but the method is a staic use
    //this will reset the user storage
    func resetLongestStreak() {
        self.userData.setAndSaveLongestStreak(0)
        self.userData.resetCurrentStreak()
        self.userData.resetPlayerScore()
        self.userData.resetCpuScore()
    }
}




//menu button for navigation and not actions that require functionality
struct MenuButtonNavigation: View {
    let buttonTitle: String
    
    var body: some View {
        Text(buttonTitle)
            .font(.system(.title3, design: .rounded))
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .frame(maxWidth: .infinity)
            .background(.purple)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}



//this is for direct actions that need to do functionality and not navigate
struct MenuButtonAction: View {
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        Button(buttonTitle, action: action)
            .font(.system(.title3, design: .rounded))
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .frame(maxWidth: .infinity)
            .background(.purple)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}







struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
