//
//  UserData.swift
//  War Card Came
//
//  Created by Dylan Kelly on 1/27/24.
//

import Foundation

class UserData :ObservableObject {
    let userKey = "longestStreak"
    let startingBet = 100
    let startingMoney = 2000
    
    
    static let shared = UserData()
    
    @Published var gameOver = true
    
    //over all longest streak
    @Published var longestStreak: Int
    
    //player and cpu score
    @Published var playerScore = 0
    @Published var cpuScore = 0
    
    //current streak which is reset after every time cpu wins
    var currentStreak = 0
    
    
    //for betting
    @Published var myMoney:Int = 1900
    @Published var bet:Int = 100
    
    //get the data when the DefaultData class is started
    private init() {
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey:self.userKey) {
            
            //check to make sure it can be converted to int
            if let converted = Int (stringOne) {
                self.longestStreak = converted
            } else {
                print("userDefaault longest streak is not a number")
                self.longestStreak = 0
            }
            
            //default does not exist in the default user
        } else {
            self.longestStreak = 0
        }
        
    }
    
    
    //getters and setters for longest streak
    func setAndSaveLongestStreak(_ num : Int) {
        self.longestStreak = num
        self.saveData(num)
    }
    
    //get the longest streak no need to access default as all sets are made by setandSave
    func getLongestStreak() -> Int {
        return self.longestStreak
    }
    
    
    
    func getCurrentStreak() -> Int {
        return self.currentStreak
    }
    
    
    //reseting streaks and score
    func resetCurrentStreak() {
        self.currentStreak = 0
    }
    
    func resetPlayerScore() {
        self.playerScore = 0
    }
    
    func resetCpuScore() {
        self.cpuScore = 0
    }
    
    
    
    //incrementing score
    func incrementPlayerScore() {
        self.playerScore = self.playerScore + 1
    }
    
    func incrementCpuScore() {
        self.cpuScore = self.cpuScore + 1
    }
    

    
    
    //storing the data to default user key
    
    func saveData(_ num: Int) {
        DataHandler.saveData(num, self.userKey)
    }
    
    
    
    //calculate the running steak based on the bool
    //if bool parameter is false then the streak has eneded and store
    //if true the stream is running and save it
    func calculateSteak(_ isRunning: Bool) {
        if (isRunning) {
            self.currentStreak = self.currentStreak + 1
            
            if(self.currentStreak > self.longestStreak) {
                self.setAndSaveLongestStreak(self.currentStreak)
            }
        } else {
            self.currentStreak = 0
        }
    }
    
    
    //function to handle if player wins add money
    func playerWon() {
        self.myMoney = self.myMoney + (self.bet * 2)
    }
    
    func handleDraw() {
        self.myMoney = self.myMoney + self.bet
    }
    
    
    func prepareNextHand() {
        self.myMoney = self.myMoney - self.startingBet
        self.bet = self.startingBet
    }
    
    func checkGameOver() {
        if(self.myMoney <= 0) {
            self.gameOver = true
        }
    }
    
    func gameReset() {
        self.myMoney = self.startingMoney
        self.bet = self.startingBet
        self.playerScore = 0
        self.cpuScore = 0
        self.currentStreak = 0
        self.gameOver = false
        self.myMoney = self.myMoney - self.startingBet
    }
    
    
    
    //for setting and getting bet
    func addBet(_ num: Int) {
        if(num >= self.myMoney) {
            self.bet = self.bet + myMoney
            self.myMoney = 0
        } else {
            self.bet = self.bet + num
            self.myMoney = self.myMoney - num
        }
        
    }
    
    
    func getBet() -> Int {
        return self.bet
    }
    
    
    func addMoney(_ num: Int) {
        self.myMoney = self.myMoney + num
    }
    
    func getMyMoney() -> Int {
        return self.myMoney
    }
    
    
    
    
}
