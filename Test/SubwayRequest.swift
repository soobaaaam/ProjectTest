//
//  SubwayRequest.swift
//  Test
//
//  Created by 정수범 on 2020/11/20.
//

import Foundation

enum SubwayError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct SubwayRequest {
    let resourceURL: URL
    let API_KEY = "AIzaSyAQhwEceve52U3tEJGd1d0Dg66OrqMqtmg"
    
    init(placeType: String) {
        
        let resourceString =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=\(API_KEY)&radius=1000&types=subway_station"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getSubway (completion: @escaping(Result<[SubwayDetail], SubwayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let subwayResult = try decoder.decode(SubwayResult.self, from: jsonData)
                let subwayDetail = subwayResult.result
                completion(.success(subwayDetail))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
