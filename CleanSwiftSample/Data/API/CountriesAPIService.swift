//
//  CountriesAPIService.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation
import Moya

enum CountriesAPIService {
    case getCountriesEU
}

extension CountriesAPIService: TargetType {
    var baseURL: URL { return URL(string: "https://restcountries.eu/rest/v2")! }
        var path: String {
            switch self {
            case .getCountriesEU:
                return "/regionalbloc/eu"
            }
        }
        var method: Moya.Method {
            switch self {
            case .getCountriesEU:
                return .get
            }
        }
        var task: Task {
            switch self {
            case .getCountriesEU: // Send no parameters
                return .requestPlain
            }
        }
        var sampleData: Data {
            switch self {
            case .getCountriesEU:
                // Provided you have a file named accounts.json in your bundle.
                guard let url = Bundle.main.url(forResource: "Countries", withExtension: "json"),
                      let data = try? Data(contentsOf: url) else {
                    return Data()
                }
                return data
            }
        }
        var headers: [String: String]? {
            return ["Content-type": "application/json"]
        }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
