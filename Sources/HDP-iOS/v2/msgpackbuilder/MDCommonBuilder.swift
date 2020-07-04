//
//  Created by Jim Wilenius on 2020-06-22.
//

import Foundation


/**
 * An abstract base for builders of msgpack events, see subclasses.
 *
 * @param <T> a subclass of MDCommonBuilder<T>
 */
public class MDCommonBuilder<T> {
    var iDeviceId : [UInt8]?                           = Optional.none
    var iBssid : [UInt8]?                              = Optional.none
    var iAnid : String?                                = Optional.none
    var iTimeStamp : MsgPackSpecificationV2.TimeStamp? = Optional.none
    
    /// This class should never be constructed in any other way than through a subclass.
    /// If T is not a subclass of MDCommonBuilder<T> then a fatalError is raised.
    public init() {
        // The type sytem does not let me define class MDCommonBuilder<T : MDCommonBuilder>
        // Which means we must make sure that T is a subclass of MDCommonBuilder<T> in some other way
        let a = self as? T
        if (a == nil) {
            fatalError("Usage error! Generic Type T \(String(describing: T.self)) must inherit MDCommonBuilder<T>")
        }
    }
    
    /**
     * @param id a byte array of size 6
     * @return a builder of type T
     */
    @discardableResult
    public func withDeviceId6Byte(_ id : [UInt8]) -> T {
        iDeviceId = id
        return self as! T
    }
    
    /**
     * @param anid a string of numeric characters, length 24
     * @return a builder of type T
     */
    @discardableResult
    public func withAnid(_ anid : String) -> T {
        iAnid = anid
        return self as! T
    }
    
    /**
     * @param bssid a byte array of size 6
     * @return a builder of type T
     */
    @discardableResult
    public func withBssid6Byte(_ bssid : [UInt8]) -> T {
        iBssid = bssid
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
        let fields : [(Any?, String)] = [
            (iDeviceId,   "DeviceId"),
            (iAnid,       "Anid"),
            (iBssid,      "Bssid"),
            (iTimeStamp,  "TimeStamp")
        ]
        try checkAllFields(fields: fields)
    }
}
