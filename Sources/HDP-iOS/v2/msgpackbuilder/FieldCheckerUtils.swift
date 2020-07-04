//
//  Created by Jim Wilenius on 2020-06-22.
//

import Foundation

/// throws IllegalArgumentException  if field is none
public func checkAllFields(fields : [(Any?, String)]) throws {
    let nilElements = fields.filter({(field, name) in field == nil})
    if (!nilElements.isEmpty) {
        let names = nilElements.map({(field, name) in return name})
        throw IllegalArgumentException("Missing fields: \(names)")
    }
}
