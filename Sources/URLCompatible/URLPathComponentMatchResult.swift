//
// Created by Mengyu Li on 2020/12/26.
//

import Foundation

enum URLPathComponentMatchResult {
    case matches((key: String, value: Any)?)
    case notMatches
}
