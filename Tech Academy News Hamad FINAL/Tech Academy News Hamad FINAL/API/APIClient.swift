
//  APIClient.swift
//  Tech Academy News Hamad FINAL
//
//  Created by DVP on 20/03/2024.
//
// API ENDPOINT = https://newsapi.org/v2/top-headlines?country=us&apiKey=6662f36d179c4970b874ac955453bb06

import Foundation

struct SpaceData : Codable, Identifiable {
    var id: Int
    var title: String
    var url: String
    var imageUrl: String
    var newsSite: String
    var summary: String
    var publishedAt: String
}

@MainActor class SpaceAPI: ObservableObject {
    @Published var news: [SpaceData] = []
    
    func getData() {
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v3/articles?_limit=10") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check if there's data, otherwise return an error object
            guard let data = data else {
                let tempError = error!.localizedDescription
                DispatchQueue.main.async {
                    self.news = [SpaceData(id: 0, title: tempError, url: "Error", imageUrl: "Error", newsSite: "Error", summary: "Try swiping down to refresh as soon as you have internet again.", publishedAt: "Error")]
                }
                return }
            
            let spaceData = try! JSONDecoder().decode([SpaceData].self, from: data)
            
            // Update the list to the latest data
            DispatchQueue.main.async {
                print("Loaded new data successfully! Articles: \(spaceData.count)")
                self.news = spaceData
            }
        }.resume()
    }
}



