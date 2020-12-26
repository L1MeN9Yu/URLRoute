//
// Created by Mengyu Li on 2020/12/26.
//

import Foundation

extension String: URLConvertible {
    public var url: URL? {
        if let url = URL(string: self) { return url }

        var set = CharacterSet()
        set.formUnion(.urlHostAllowed)
        set.formUnion(.urlPathAllowed)
        set.formUnion(.urlQueryAllowed)
        set.formUnion(.urlFragmentAllowed)

        return addingPercentEncoding(withAllowedCharacters: set).flatMap { URL(string: $0) }
    }

    public var string: String { self }
}
