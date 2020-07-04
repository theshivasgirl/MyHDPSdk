//
//  Created by Jim Wilenius on 2020-06-18.
//

import Foundation


public class DeviceTrafficEventBuilder : CommonBuilder<DeviceTrafficEventBuilder> {
    var iDeviceId : Array<UInt8>?     = Optional.none
    var iSignalStrength : Int?        = Optional.none
    var iAuthenticationState : Bool?  = Optional.none
    var iActive : Bool?               = Optional.none
    var iPacketsSent : Int64?         = Optional.none
    var iPacketsReceived : Int64?     = Optional.none

    
    public override init() {
        super.init()
    }
    
    /**
     * @return MsgPackSpecificationV1.DeviceTrafficEvent
     * @throws IllegalArgumentException if any of the fields are not defined
     * @throws EventValidationException if the validation of the event field domains finds a problem.
     */
    public func build() throws -> MsgPackSpecificationV2.DeviceTrafficEvent {
        try checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()
        let event : MsgPackSpecificationV2.DeviceTrafficEvent =
                MsgPackSpecificationV2.DeviceTrafficEvent(
                        MsgPackSpecificationV2.DeviceTrafficEvent.API_DEFINED_MSG_TYPE,
                        iTimeStamp!, iRouterId!, iDeviceId!, iSignalStrength!,
                        iAuthenticationState!, iActive!, iPacketsSent!, iPacketsReceived!)

        try event.validate()

        return event
    }

    /// throws IllegalArgumentException if any field is Optional.none
    
    override func checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional() throws {
        try super.checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()
        let fields : [(Any?, String)] = [
            (iDeviceId,            "DeviceId"),
            (iSignalStrength,      "SignalStrength"),
            (iAuthenticationState, "AuthenticationState"),
            (iActive,              "Active"),
            (iPacketsSent,         "PacketsSent"),
            (iPacketsReceived,     "PacketsReceived")
        ]
        
        try checkAllFields(fields: fields)
    }

    /**
     * @param id a byte array of size 6
     * @return the DeviceTrafficEventBuilder
     */
    @discardableResult
    public func withDeviceId(_ id : [UInt8]) -> DeviceTrafficEventBuilder {
        iDeviceId = id
        return self
    }

    @discardableResult
    public func withSignalStrength(_ id : Int) -> DeviceTrafficEventBuilder {
        iSignalStrength = id
        return self
    }

    @discardableResult
    public func withAuthenticationState(_ state : Bool) -> DeviceTrafficEventBuilder {
        iAuthenticationState = state
        return self
    }

    @discardableResult
    public func withActive(_ state : Bool) -> DeviceTrafficEventBuilder {
        iActive = state
        return self
    }

    @discardableResult
    public func withPacketsSent(_ count : Int64) -> DeviceTrafficEventBuilder {
        iPacketsSent = count
        return self
    }

    @discardableResult
    public func withPacketsReceived(_ count : Int64) -> DeviceTrafficEventBuilder {
        iPacketsReceived = count
        return self
    }

}
