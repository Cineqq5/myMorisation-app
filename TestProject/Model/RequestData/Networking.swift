//
//  Networking.swift
//  TestProject
//
//  Created by Morten on 12/05/2024.
//

import Foundation

struct Networking{
    func callAPI(uri: String, requestMethod: String, requestBody: Data?){
        
        let url = URL(string: uri)!

        var request = URLRequest(url: url)
        request.httpMethod = requestMethod
        request.httpBody = requestBody ?? nil
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode

            if statusCode == 200 {
                print("SUCCESS")
            } else {
                print("FAILURE - \(statusCode)")
                print(url)
            }
        }
        task.resume()
    }
}
