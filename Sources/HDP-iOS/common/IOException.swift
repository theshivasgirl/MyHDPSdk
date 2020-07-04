//
//  Created by Jim Wilenius on 2020-06-15.
//

import Foundation

public class IOException : Error {
    public let message : String
    
    init(_ message : String) {
        self.message = message
    }
}
