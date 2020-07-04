//
//  Created by Jim Wilenius on 2020-06-18.
//

import Foundation


///
/// An abstract base for builders of msgpack events, see subclasses.
/// All events contain a routerID and timestamp. This class has
/// the methods for adding that information.
///
/// This class should never be constructed in any other way than through a subclass.
///
public class CommonBuilder<T> {
    var iRouterId : MsgPackSpecificationV2.RouterId?   = Optional.none
    var iTimeStamp : MsgPackSpecificationV2.TimeStamp? = Optional.none

    /// This class should never be constructed in any other way than through a subclass.
    /// If T is not a subclass of CommonBuilder<T> then a fatalError is raised.
    /// Creates an empty builder.
    public init() {
        // The type sytem does not let me define class CommonBuilder<T : CommonBuilder>
        // Which means we must make sure that T is a subclass of CommonBuilder<T> in some other way
        let a = self as? T
        if (a == nil) {
            fatalError("Usage error! Generic Type T \(String(describing: T.self)) must inherit CommonBuilder<T>")
        }
    }
   
    /**
     * @param id a numeric string of length 25
     * @return a builder of type T
     */
    @discardableResult
    public func withRouterIdNumericString(_ id : String) -> T {
        iRouterId = MsgPackSpecificationV2.RouterId.routerId(id)
        return self as! T
    }
    
    /**
     * @param id a byte array of size 6
     * @return a builder of type T
     */
    @discardableResult
    public func withRouterId6Byte(_ id : [UInt8]) -> T {
        iRouterId = MsgPackSpecificationV2.RouterId.routerMac(id)
        return self as! T
    }
    
    /**
     * @param id a byte array of size 6 or a numberic string of size 25
     * @return a builder of type T
     */
    @discardableResult
    public func withRouterId(_ id : MsgPackSpecificationV2.RouterId) -> T {
        iRouterId = id
        return self as! T
    }
    
    ///
    /// - seconds since 1970-01-01T00:00:00Z
    /// - nanos part of the second
    ///
    @discardableResult
    public func withTimeStamp(secondsSince1970 : UInt64, nanos : Int ) -> T {
        iTimeStamp = MsgPackSpecificationV2.TimeStamp(secondsSince1970, nanos)
        return self as! T
    }
    
    ///
    /// The current time measured from 1970-01-01T00:00:00Z
    ///
    @discardableResult
    public func withTimeStampNow() -> T {
        let now : Double = NSDate().timeIntervalSince1970
        let seconds : Double = floor(now)
        let nanos : Int = Int(round((now - seconds) * 1.0e9))
        iTimeStamp = MsgPackSpecificationV2.TimeStamp(UInt64(seconds), nanos)
        return self as! T
    }
    
    @discardableResult
    public func withTimeStamp(_ timeStamp : MsgPackSpecificationV2.TimeStamp) -> T {
        iTimeStamp = timeStamp
        return self as! T
    }
    
    /// throws IllegalArgumentException if any of the members are Optiona.none
    func checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional() throws {
        try checkAllFields(fields: [(iRouterId, "RouterId"), (iTimeStamp, "TimeStamp")])
    }
}
