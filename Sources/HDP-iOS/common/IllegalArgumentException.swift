//
//  Created by Jim Wilenius on 2020-06-17.
//

import Foundation

public class IllegalArgumentException : Error {
    public let message : String
    
    init(_ message : String) {
        self.message = message
    }
}
