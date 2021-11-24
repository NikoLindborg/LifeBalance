//
//  FoodParser.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 22.11.2021.
//

import Foundation

class FoodParser: ObservableObject {
    let constants = Constants()
    @Published var queryList: [Hints] = []
    
    func parseFood(_ query: String) {
        guard let url = URL(string: "https://api.edamam.com/api/food-database/v2/parser?app_id=\(constants.app_id)&app_key=\(constants.app_key)&ingr=\(query)&nutrition-type=cooking") else{
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200 {
                guard let data = data else {return}
                DispatchQueue.main.async {
                    do {
                        let decodeQuery = try JSONDecoder().decode(ParsedModel.self, from: data)
                        self.queryList = decodeQuery.hints
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
