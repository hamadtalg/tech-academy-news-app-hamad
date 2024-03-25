//
//  APIClient.swift
//  Hamad's News App
//
//  Created by DVP on 19/03/2024.
//
// API endpoint: https://newsapi.org/v2/top-headlines?country=us&apiKey=6662f36d179c4970b874ac955453bb06
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
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6662f36d179c4970b874ac955453bb06?_limit=10") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                let tempError = error!.localizedDescription
                DispatchQueue.main.async {
                    self.news = [SpaceData(id: 0, title: tempError, url: "Error", imageUrl: "Error", newsSite: "Error", summary: "Please Check Internet Connection and Refresh", publishedAt: "Error")]
                }
                return
            }
            let SpaceData = try! JSONDecoder().decode([SpaceData].self, from: data)
            DispatchQueue.main.async {
                print("Loaded new data successfully. Articles: \(SpaceData.count)")
                self.news = SpaceData
            }
        }.resume()
    }
}
