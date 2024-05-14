//
//  FlashCardManager.swift
//  TestProject
//
//  Created by Morten on 04/05/2024.
//

import Foundation


protocol UserManagerDelegate {
    func didUpdateUsers(_ userManager: UserManager, users: [User])
    func didVerifiedUser(_ userManager: UserManager, users: UserInfoDto)
//    func didFailWithError(error: Error)
}

struct UserManager{
    
    let backendURL = "https://979d-2a02-a317-223e-8e80-f8dd-caec-3fdd-1614.ngrok-free.app" + "/users"
    
    var delegate: UserManagerDelegate?
    
    var table = [User]()
    
    
    mutating func removeFromList(user: User){
        if let index = table.firstIndex(where: {$0.id == user.id}){
            table.remove(at: index)
        }
    }
    func getUserData(){
        perfromRequest(urlString: backendURL)
    }
    
    func perfromRequest(urlString: String){
        if let url = URL(string: urlString + "/all"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    print(safeData)
                    if let users = parseJSONToUser(safeData){
                        print(users)
                        print("sendingToDelegate")
                        delegate?.didUpdateUsers(self, users: users)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func perfromRequest(user: NewUserRequest){
        if let url = URL(string: backendURL + "/verify"){
            
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.httpMethod = "Post"
            let data = try! JSONEncoder().encode(user)
            request.httpBody = data
            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    print(safeData)
                    if let user = parseJSONToUserInfoDto(safeData){
                        print(user)
                        print("sendingToDelegate")
                        delegate?.didVerifiedUser(self, users: user)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSONToUser(_ usersData: Data) -> [User]? {
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
        do {
            let decodedData = try decoder.decode([UserRecord].self, from: usersData)
            var users = [User]()
            for decodedRecord in decodedData{
                let id = decodedRecord.id
                let username = decodedRecord.username
                let userType = decodedRecord.userType
                users.append(User(i: id, u: username, r: userType))
            }
            return users
            
        } catch {
            print(error)
            return nil
        }
    }
    
    func parseJSONToUserInfoDto(_ userData: Data) -> UserInfoDto? {
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
        do {
            let decodedData = try decoder.decode(UserInfoDto.self, from: userData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
//    func handle(data: Data?, response: URLResponse?, error: Error?){
//        if error != nil {
//            print(error!)
//            return
//        }
//        
//        if let safeData = data {
//            let dataString = String(data: safeData, encoding: .utf8)
//        }
//    }
    
    //-------------------------
    
    func createUser(username: String, password: String){
//        let requestBody = NewUserRequest(username: username, password: password)
//        let data = try! JSONEncoder().encode(requestBody)
//        Networking().callAPI(uri: backendURL , requestMethod: "POST", requestBody: data)
        
        if let url = URL(string: backendURL){
            
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let requestBody = NewUserRequest(username: username, password: password)
            let data = try! JSONEncoder().encode(requestBody)
            request.httpBody = data
            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    print(safeData)
                    if let user = parseJSONToUserInfoDto(safeData){
                        print(user)
                        print("sendingToDelegate")
                        delegate?.didVerifiedUser(self, users: user)
                    }
                }
            }
            task.resume()
        }
    }
    
    func updateUser(userId: Int, role: String){
        Networking().callAPI(uri: backendURL + "/users/\(userId)", requestMethod: "PUT", requestBody: nil)
    }
    
    func updateUserRole(userId: Int, username: String, password: String){
        let updateRequest = NewUserRequest(username: username, password: password)
        let data = try! JSONEncoder().encode(updateRequest)
        print(data)
        Networking().callAPI(uri: backendURL + "/users/\(userId)", requestMethod: "PUT", requestBody: data)
    }
    
    func deleteUser(userId: String) {
        Networking().callAPI(uri: backendURL + "/\(userId)", requestMethod: "DELETE", requestBody: nil)
        
    }

}
