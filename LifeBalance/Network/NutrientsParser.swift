//
//  Nutrients.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 22.11.2021.
//

import Foundation
//
//  FoodParser.swift
//  LifeBalance
//
//  Created by Niko Lindborg on 22.11.2021.
//

import Foundation

class NutrientsParser: ObservableObject {
    let constants = Constants()
    @Published var nutrientsList: [totalNutrients] = []
    
    func parseNutrients(_ foodId: String, _ quantity: Int, _ measureURI: String ) {
        
        let body: Dictionary<String, Any> = ["ingredients": [[
            "quantity": quantity,
            "measureURI": measureURI,
            "foodId": foodId
            ]]
        ]
    
        if (!JSONSerialization.isValidJSONObject(body)) {
                print("is not a valid json object")
                return
            }

        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        guard let url = URL(string: "https://api.edamam.com/api/food-database/v2/nutrients?app_id=\(constants.app_id)&app_key=\(constants.app_key)") else{
            fatalError("Missing URL")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]

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
                        let decodeQuery = try JSONDecoder().decode(NutrientsModel.self, from: data)
                        self.nutrientsList = [decodeQuery.totalNutrients]
                        print(self.nutrientsList)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
