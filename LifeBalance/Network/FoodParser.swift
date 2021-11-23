//
//  FoodParser.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 22.11.2021.
//

import Foundation

class FoodParser: ObservableObject {
    let constants = Constants()
    @Published var queryList: [ParsedModel] = []
    var query: String
    
    init(_ query: String){
        self.query = query
    }
    func parseFood() {
        guard let url = URL(string: "https://api.edamam.com/api/food-database/v2/parser?app_id=\(constants.app_id)&app_key=\(constants.app_key)&ingr=chicken&nutrition-type=cooking") else{
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
                print(data)
                DispatchQueue.main.async {
                    do {
                        let decodeQuery = try JSONDecoder().decode([ParsedModel].self, from: data)
                        self.queryList = decodeQuery
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
