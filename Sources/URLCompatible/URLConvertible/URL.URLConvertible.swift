//
// Created by Mengyu Li on 2020/12/26.
//

import Foundation

extension URL: URLConvertible {
    public var url: URL? { self }

    public var string: String { absoluteString }
}
