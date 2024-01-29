//
//  DataHandler.swift
//  War Card Came
//
//  Created by Dylan Kelly on 1/28/24.
//

import Foundation

struct DataHandler {
    
    static func getLongestStreak() -> Int {
        var longest = 0
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey:"longestStreak") {
            
            //check to make sure it can be converted to int
            if let converted = Int (stringOne) {
                longest = converted
            } else {
                print("userDefaault longest streak is not a number")
                longest = 0
            }
        }
        return longest
    }
    
    
    
    //static call to sync the save calls
    static func saveData(_ num: Int, _ key: String) {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        defaults.set(String(num), forKey: key)
    }
}
