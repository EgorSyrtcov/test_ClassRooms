//
//  Service.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import Foundation

class Service {
    
    static func fetchReques<T: Decodable>(completion: @escaping (T) -> Void) {
        
        guard let path = Bundle.main.path(forResource: "generated", ofType: "json") else { return }
        
        let jsonUrl = URL(fileURLWithPath: path)
        URLSession.shared.dataTask(with: jsonUrl) { (data, response, error) in
             
            guard let data = data else { return }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                    completion(obj)

            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        }.resume()
    }
}
