//
//  Created by Jim Wilenius on 2020-06-22.
//

import Foundation


/**
 * An abstract base for builders of msgpack events, see subclasses.
 *
 * @param <T> a subclass of MDCommonBuilder<T>
 */
public class TVCommonBuilder<T> : CommonBuilder<T> {
    var iTvId : [UInt8]?   = Optional.none
    var iSnid : String?    = Optional.none
    var iAnid : String?    = Optional.none
    var iBssid : [UInt8]?  = Optional.none

    /// This class should never be constructed in any other way than through a subclass.
    /// If T is not a subclass of MDCommonBuilder<T> then a fatalError is raised.
    public override init() {
        super.init()
        
        // The type sytem does not let me define class MDCommonBuilder<T : MDCommonBuilder>
        // Which means we must make sure that T is a subclass of MDCommonBuilder<T> in some other way
        let a = self as? T
        if (a == nil) {
            fatalError("Usage error! Generic Type T \(String(describing: T.self)) must inherit TVCommonBuilder<T>")
        }
    }
    
    /// throws IllegalArgumentException if any of the members are Optiona.none
    override func checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional() throws {
        try super.checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()
        
        let fields : [(Any?, String)] = [
            (iTvId,       "TvId"),
            (iSnid,       "Snid"),
            (iAnid,       "Anid"),
            (iBssid,      "Bssid"),
        ]
        try checkAllFields(fields: fields)
    }
    
    /**
     * @param id a byte array of size 6
     * @return the TVPlayEventBuilder
     */
    @discardableResult
    public func withTvId(_ id : [UInt8]) -> T {
        iTvId = id
        return self as! T
    }

    /**
     * @param snid a string of length less than or equal to 128
     * @return a builder of type T
     */
    @discardableResult
    public func withSnid(_ snid : String) -> T {
        iSnid = snid
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
}


