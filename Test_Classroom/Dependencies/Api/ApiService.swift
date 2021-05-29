//
//  ApiService.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/29/21.
//

import Foundation

enum RequestURL {
    case localMock
    
    var url: URL? {
        switch self {
        case .localMock:
            guard let path = Bundle.main.path(forResource: "generated", ofType: "json") else { return nil }
            return URL(fileURLWithPath: path)
        }
    }
}

final class ApiService {
    
    func fetchReques<T: Decodable>(requestURL: RequestURL, completion: @escaping (T) -> Void) {
        guard let url = requestURL.url else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                switch requestURL {
                case .localMock:
                    DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                        completion(obj)
                    }
                }
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        }.resume()
    }
}
