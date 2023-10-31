//
//  TestService.swift
//  TCA_tutorial
//
//  Created by VP on 2023/10/31.
//

import Foundation
import ComposableArchitecture

protocol NumbersAPI {
    func requestNumbersAPI(category: NumbersAPIClient.Category) async throws -> String
}

class NumbersAPIClient: NumbersAPI {
    enum Category: String {
        case trivia = "trivia"
        case math = "math"
        case date = "date"
        case year = "year"
    }
    
    func requestNumbersAPI(category: NumbersAPIClient.Category) async throws -> String {
        let url = URL(string: "http://numbersapi.com/random/\(category)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return String(data: data, encoding: .utf8)!
    }
}

private enum NumbersAPIClientKey: DependencyKey {
    static var liveValue: NumbersAPI = NumbersAPIClient()
}

extension DependencyValues {
    var randomNumber: NumbersAPI {
        get { self[NumbersAPIClientKey.self] }
        set { self[NumbersAPIClientKey.self] = newValue}
    }
}
