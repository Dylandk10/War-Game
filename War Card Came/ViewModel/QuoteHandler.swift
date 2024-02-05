//
//  QuoteHandler.swift
//  War Card Came
//
//  Created by Dylan Kelly on 2/2/24.
//

import Foundation

class QuoteHandler : ObservableObject {
    @Published var quotes: [Quotes] = []
    
    init() {
        self.quotes = getJson()
    }
    
    //we know this file exist so we will keep it like this because we know the exact structure
    func getJson() -> [Quotes] {
        
        let modelsUrl = Bundle.main.url(forResource: "data", withExtension: "json")!
        let modelsData = try! Data(contentsOf: modelsUrl)
        let importedModels = try! JSONDecoder().decode([Quotes].self, from: modelsData)
        return importedModels
    }
    
    
    
}

struct Quotes: Decodable {
    let id: String
    let name: String
    let symbol: String
    let quote: String
}
