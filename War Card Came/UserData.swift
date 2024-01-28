//
//  UserData.swift
//  War Card Came
//
//  Created by Dylan Kelly on 1/27/24.
//

import Foundation

class UserData {
    let userKey = "longestStreak"
    
    //over all longest streak
    var longestStreak: Int = 0
    
    //current streak
    var currentStreak = 0
    
    
    func setAndSaveLongestStreak(_ num : Int) {
        self.longestStreak = num
        self.saveData(num)
    }
    
    func getLongestStreak() -> Int {
        return self.longestStreak
    }
    
    
    //get the data when the DefaultData class is started
    init() {
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
    
    
    //storing the data to default user key
    
    func saveData(_ num: Int) {
        let defaults = UserDefaults.standard
        defaults.set(String(num), forKey: self.userKey)
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
}
