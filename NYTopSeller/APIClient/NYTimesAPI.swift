//
//  NYTimesAPI.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/6/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTimesAPI {
    static func getTopStories(section: String, completionHandler: @escaping(Result<[Article], AppError>) -> ()) {
        let endpointURL = "https://api.nytimes.com/svc/topstories/v2/\(section).json?api-key=\(Config.apiKey)"
        guard let url = URL(string: endpointURL) else {
            completionHandler(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completionHandler(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let newsData = try JSONDecoder().decode(TopStories.self, from: data)
                    completionHandler(.success(newsData.results))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
