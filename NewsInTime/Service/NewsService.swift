//
//  NewsService.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine

var newsFeed = [
    NewsModel(id: 0,
              title: "A very big news title to comply with the 2 lines rule #0",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """,
              highlight: true),
    NewsModel(id: 1,
              title: "A very big news title to comply with the 2 lines rule #1",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """,
              highlight: true),
    NewsModel(id: 2,
              title: "A very big news title to comply with the 2 lines rule #02",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """,
              highlight: false),
    NewsModel(id: 3,
              title: "A very big news title to comply with the 2 lines rule #3",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """,
              highlight: false),
    NewsModel(id: 4,
              title: "A very big news title to comply with the 2 lines rule #4",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """,
              highlight: true) // for testing purposes
]

/// Type  of authentiation
///
///
enum AuthenticationMode {
    case signIn
    case signUp
}

/// Base URL used in all app requisitions
///
///
let baseURL = "https://mesa-news-api.herokuapp.com"

/// Token for user authentication
///
///
private var token: String?

/// Protocol used when a class need authentication delegation
///
///
protocol ServiceAuthenticationDelegate: class {
    func authentication(name: String?,
                        email: String,
                        password: String,
                        for mode: AuthenticationMode,
                        completion: @escaping (Bool) -> Void)
}

/// Protocol used when a class need requisition services
///
///
protocol ServiceDelegate: class {
    func get(for endpoint: String, completion: @escaping ([NewsModel]) -> Void)
}

/// The service used for HTTP communication layer for the app
///
///
class Service: ServiceDelegate, ServiceAuthenticationDelegate {

    /// Manager used for HTTPS requisitions
    ///
    ///
    let manager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default

        let manager = Alamofire.Session(configuration: configuration)
        return manager
    }()

    /// Authentication method for HTTP communication 
    ///
    ///
    /// - Parameter name: `String?` name of the user,  optional if it's for sign in mode
    /// - Parameter email: `String` email of the user, obrigatory for all modes
    /// - Parameter password: `String` password of the user, obrigatory for all modes
    /// - Parameter for mode: `AuthenticationMode` the type of authentication
    func authentication(
        name: String? = nil,
        email: String,
        password: String,
        for mode: AuthenticationMode,
        completion: @escaping (Bool) -> Void) {

        var endpoint: String
        var parameter: String

        switch mode {
        case .signIn:
            endpoint = "signin"
            parameter = "{\n\t\"email\": \"\(email)\",\n\t\"password\": \"\(password)\"\n}"
        case .signUp:
            endpoint = "signup"
            parameter = "{\n\t\"name\": \"\(name!)\",\n\t\"email\": \"\(email)\",\n\t\"password\": \"\(password)\"\n}"
        }

        self.manager.request(
            "\(baseURL)/v1/client/auth/\(endpoint)",
            method: .post,
            parameters: [:],
            encoding: parameter,
            headers: [.contentType("application/json")])
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    if let responseToken = JSON(value)["token"].string {
                        token = responseToken
                        print("Success on sign up: \(JSON(value))")
                        completion(true)
                    } else {
                        print("Could not decode the token.")
                        completion(false)
                    }
                case .failure(let error):
                    completion(false)
                    print("Error on sign up: \(error._code)")
                }
            })
    }

    /// Fetch all news from Service
    ///
    ///
    /// - Parameter currentPage: `String` the current page for pagination
    /// - Parameter perPage: `String` page filter for pagination
    /// - Parameter publishedAt: `String` published date filter for pagination
    func get(for endpoint: String, completion: @escaping ([NewsModel]) -> Void) {

        var newsFeedItems: [NewsModel] = []
        let dispatchQueue = DispatchQueue(label: "getNews")
        let dispatchGroup = DispatchGroup()

        dispatchQueue.async {
            dispatchGroup.enter()
            self.manager.request(
                "\(baseURL)/v1/client/news\(endpoint)",
                method: .get,
                headers: [.contentType("application/json"), .authorization(bearerToken: token!)])
                .validate()
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .failure(let error):
                        print(error.errorDescription!)
                    case .success(let data):
                        var id = 0
                        var newsFeedWithId: [NewsModel] = []
                        let newsFeed = NewsFeedModel(with: JSON(data))
                        newsFeed.newsFeed.forEach { (feed) in
                            var newFeed = feed
                            newFeed.id = id
                            newsFeedWithId.append(newFeed)
                            id += 1
                        }
                        newsFeedItems = newsFeedWithId
                        completion(newsFeedItems)
                        dispatchGroup.leave()
                    }
                })
        }
    }

}

// MARK: - Encoding AlamoFire parameter to uft8

/// Extension to force Alamofire's parameter encode to utf8
///
///
extension String: ParameterEncoding {

    /// Forces the body's parameter to UTF-8
    ///
    ///
    /// - Parameter urlRequest: `URLRequestConvertible`  the request from Alamofire's session manager
    /// - Parameter with parameters: `Parameters` the parameter's from request to be converted to UTF-8
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }

}
