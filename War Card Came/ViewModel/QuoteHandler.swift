//
//  QuoteHandler.swift
//  War Card Came
//
//  Created by Dylan Kelly on 2/2/24.
//

import Foundation

class QuoteHandler : ObservableObject {
    @Published var quotes: [Quotes] = []
    @Published var singleQuote: Quotes = Quotes(id: "", name: "", symbol: "", quote: "")
    
    init() {
        self.quotes = getJson()
        self.singleQuote = getSingleQuote()
    }
    
    //we know this file exist so we will keep it like this because we know the exact structure
    func getJson() -> [Quotes] {
        
        let modelsUrl = Bundle.main.url(forResource: "data", withExtension: "json")!
        let modelsData = try! Data(contentsOf: modelsUrl)
        let importedModels = try! JSONDecoder().decode([Quotes].self, from: modelsData)
        return importedModels
    }
    
    func getSingleQuote() -> Quotes {
        let rand = Int.random(in: 0...quotes.count-1)
        return self.quotes[rand]
    }
    
    func setNewQuote() -> Void {
        let rand = Int.random(in: 0...quotes.count-1)
        self.singleQuote = self.quotes[rand]
    }
    
    
    
}

struct Quotes: Decodable {
    let id: String
    let name: String
    let symbol: String
    let quote: String
}
