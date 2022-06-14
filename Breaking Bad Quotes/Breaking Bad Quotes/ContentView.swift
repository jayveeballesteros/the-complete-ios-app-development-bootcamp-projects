//
//  ContentView.swift
//  Breaking Bad Quotes
//
//  Created by Jayvee Ballesteros on 5/20/22.
//

import SwiftUI

struct Quote: Codable {
    var quote_id: Int
    var quote: String
    var author: String
    var series: String
}

struct ContentView: View {
    
    @State private var quotes = [Quote]()
    
    var body: some View {
        
        
        NavigationView {
                List(quotes, id: \.quote_id) { quote in
                    VStack(alignment: .leading) {
                        Text(quote.author)
                            .font(.headline)
                        Text(quote.quote)
                            .font(.body)
                    }
            }
            .navigationTitle("Quotes")
            .task {
                await fetchData()
            }
        
        }
        
        
    }
    
    func fetchData() async {
        // create url
        guard let url = URL(string: "https://www.breakingbadapi.com/api/quote/random") else {
            print("This url does not work.")
            return
        }
        // fetch data from that url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // decode that data
            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                quotes = decodedResponse
            }
        }
        catch {
            print("This data isn't valid.")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
