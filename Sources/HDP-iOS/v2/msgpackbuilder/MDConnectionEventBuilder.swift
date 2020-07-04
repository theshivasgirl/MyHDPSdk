//
//  Created by Jim Wilenius on 2020-06-18.
//

import Foundation

   
/**
 * A builder for creating (v1) {@link MsgPackSpecificationV2.MDConnectionEventBuilder}
 */
public class MDConnectionEventBuilder : MDCommonBuilder<MDConnectionEventBuilder> {
    var iWifiConnected : Bool?   = Optional.none
    var iConnectionClass : Int?  = Optional.none

    /// This class should never be constructed in any other way than through a subclass.
    /// If T is not a subclass of CommonBuilder<T> then a fatalError is raised.
    /// Creates an empty builder.
    public override init() {
        super.init()
    }

    /**
     * @return MsgPackSpecificationV1.MDConnectionEvent
     * @throws IllegalArgumentException if any of the fields are none
     * @throws EventValidationException if the validation of the event field domains finds a problem.
     */
    public func build() throws -> MsgPackSpecificationV2.MDConnectionEvent {
        try checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()
        let event = MsgPackSpecificationV2.MDConnectionEvent(
                        MsgPackSpecificationV2.MDConnectionEvent.API_DEFINED_MSG_TYPE,
                        iDeviceId!, iAnid!, iBssid!, iTimeStamp!, iWifiConnected!, iConnectionClass!)

        try event.validate()

        return event
    }

    @discardableResult
    public func withWifiConnected(_ isConnected : Bool) -> MDConnectionEventBuilder {
        iWifiConnected = isConnected
        return self
    }

    @discardableResult
    public func withConnectionClass(_ connectionClass : Int) -> MDConnectionEventBuilder {
        iConnectionClass = connectionClass
        return self
    }

    // throws IllegalArgumentException if any field is none
    override func checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional() throws {
        try super.checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()
        let fields : [(Any?, String)] = [
            (iWifiConnected,   "WifiConnected"),
            (iConnectionClass, "ConnectionClass"),
        ]
        try checkAllFields(fields: fields)
    }

}
