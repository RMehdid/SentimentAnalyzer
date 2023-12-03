//
//  ContentView.swift
//  SentimentAnalysisApp
//
//  Created by Samy Mehdid on 3/12/2023.
//

import SwiftUI
import NaturalLanguage

struct ContentView: View {
    @State private var inputText: String = ""
    
    private var score: String {
        return analyzeSentiment(for: inputText)
    }
    
    private let tagger = NLTagger(tagSchemes: [.sentimentScore])
    
    var body: some View {
        VStack {
            Text("Sentiment Analyzer")
            TextField("Enter text", text: $inputText)
            Text(score)
        }
        .padding()
    }
    
    private func analyzeSentiment(for stringToAnalyze: String) -> String {
        tagger.string = stringToAnalyze
        
        let (sentimentScore, _) = tagger.tag(
            at: stringToAnalyze.startIndex,
            unit: .paragraph,
            scheme: .sentimentScore
        )
        
        return sentimentScore?.rawValue ?? ""
    }
}

#Preview {
    ContentView()
}
