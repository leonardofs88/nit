//
//  NewsService.swift
//  News In TIme
//
//  Created by Leonardo Soares on 24/04/21.
//

import Foundation
import Alamofire
import SwiftyJSON

var newsFeed = [
    NewsModel(id: 0,
              title: "A very big news title to comply with the 2 lines rule #0",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """),
    NewsModel(id: 1,
              title: "A very big news title to comply with the 2 lines rule #1",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """),
    NewsModel(id: 2,
              title: "A very big news title to comply with the 2 lines rule #02",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """),
    NewsModel(id: 3,
              title: "A very big news title to comply with the 2 lines rule #3",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """),
    NewsModel(id: 4,
              title: "A very big news title to comply with the 2 lines rule #4",
              description: """
            Mussum Ipsum, cacilds vidis litro abertis.
            Em pé sem cair, deitado sem dormir, sentado sem cochilar e fazendo pose.
            Tá deprimidis, eu conheço uma cachacis que pode alegrar sua vidis.
            Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.
            In elementis mé pra quem é amistosis quis leo.
            """) // for testing purposes
]

class Service {private static var manager: Alamofire.Session = {

    let configuration = URLSessionConfiguration.default
    let headers: HTTPHeaders =
        [
            // swiftlint:disable line_length
            .authorization(
                bearerToken:
                    "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU5LCJlbWFpbCI6ImRpbWFzLmdhYnJpZWxAenJvYmFuay5jb20uYnIifQ.a3j7sRx8FIedZCfDGLocduOYpcibfIenX7TVJjv6Sis"),
            // swiftlint:enable line_length
            .contentType("application/json")
        ]

    let manager = Alamofire.Session(configuration: configuration)
    return manager
}()

static let sharedInstance = Service()

func signUp(name: String, password: String, email: String, completion: @escaping (Bool) -> Void) {

    Service.manager.request(
        "https://mesa-news-api.herokuapp.com/v1/client/auth/signup",
        method: .post,
        parameters: [:],
        encoding: "{\n\t\"name\": \"\(name)\",\n\t\"email\": \"\(email)\",\n\t\"password\": \"\(password)\"\n}",
        headers: [.contentType("application/json")])
        .responseJSON(completionHandler: { (response) in
        switch response.result {
        case .success(let value):
            print("Success on login: \(JSON(value))")
            completion(true)
        case .failure(let error):
            completion(false)
            print("Error on login: \(error._code)")
        }
    })
}

}

extension String: ParameterEncoding {

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }

}
