//
// Created by Mengyu Li on 2020/12/26.
//

import Foundation

public protocol URLConvertible {
    var url: URL? { get }
    var string: String { get }

    /// Returns URL query parameters. For convenience, this property will never return `nil` even if
    /// there's no query string in the URL. This property doesn't take care of the duplicated keys.
    /// For checking duplicated keys, use `queryItems` instead.
    ///
    /// - seealso: `queryItems`
    var queryParameters: [String: String] { get }

    /// Returns `queryItems` property of `URLComponents` instance.
    ///
    /// - seealso: `queryParameters`
    var queryItems: [URLQueryItem]? { get }
}

public extension URLConvertible {
    var queryParameters: [String: String] {
        var parameters = [String: String]()
        url?.query?.components(separatedBy: "&").forEach { component in
            guard let separatorIndex = component.firstIndex(of: "=") else { return }
            let keyRange = component.startIndex..<separatorIndex
            let valueRange = component.index(after: separatorIndex)..<component.endIndex
            let key = String(component[keyRange])
            let value = component[valueRange].removingPercentEncoding ?? String(component[valueRange])
            parameters[key] = value
        }
        return parameters
    }

    var queryItems: [URLQueryItem]? {
        URLComponents(string: string)?.queryItems
    }
}
