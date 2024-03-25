//
//  NewsArticle.swift
//  Tech Academy News Hamad FINAL
//
//  Created by DVP on 20/03/2024.
//

import SwiftUI
import CachedAsyncImage

struct NewsArticle: View {
    let title: String
    let imageUrl: String
    let siteName: String
    let summary: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(siteName)
                .foregroundColor(.blue)
                .italic()
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                CachedAsyncImage(url: URL(string: imageUrl),
                                 transaction: Transaction(animation: .easeInOut)) {phase in
                    if let image = phase.image{
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        ProgressView(value: 0.2)
                        
                    }
                }
                Text(title)
                    .font(.headline)
                    .padding(8)
                Text(summary)
                    .lineLimit(6)
                    .font(.body)
                    .padding(8)
            }
        }
    }
}
        
        struct NewsArticle_Previews: PreviewProvider {
            static var previews: some View {
                NewsArticle(title: "Automatons sighted on Draupnir", imageUrl: "...", siteName: "Super Earth High Command", summary: "Enemy Automatons have been sighted on Draupnir, previously thought to be liberated.")}
        }
