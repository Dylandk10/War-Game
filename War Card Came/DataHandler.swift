//
//  DataHandler.swift
//  War Card Came
//
//  Created by Dylan Kelly on 1/28/24.
//

import Foundation

struct DataHandler {
    
    
    //static call to sync the save calls
    static func saveData(_ num: Int, _ key: String) {
        let defaults = UserDefaults.standard
        defaults.set(String(num), forKey: key)
    }
}
