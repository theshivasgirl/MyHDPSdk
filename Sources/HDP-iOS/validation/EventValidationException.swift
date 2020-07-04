//
//  Created by Jim Wilenius on 2020-06-12.
//

public struct EventValidationException : Error {
    public let message : String
    
    init(_ message : String) {
        self.message = message
    }
}
