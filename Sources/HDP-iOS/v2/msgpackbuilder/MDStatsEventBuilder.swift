//
//  Created by Jim Wilenius on 2020-06-18.
//

import Foundation


/**
 * A builder for creating (v1) {@link MsgPackSpecificationV2.MDStatsEvent}
 */
public class MDStatsEventBuilder : MDCommonBuilder<MDStatsEventBuilder> {
    public static let MEGABYTES_TO_BYTES : Int = 1024 * 1024
    var iConnectionTime : UInt64? = Optional.none
    var iConnectionData : UInt64? = Optional.none

    /// This class should never be constructed in any other way than through a subclass.
    /// If T is not a subclass of CommonBuilder<T> then a fatalError is raised.
    /// Creates an empty builder.
    public override init() {
        super.init()
    }

    /**
     * @return MsgPackSpecificationV1.MDStatsEvent
     * @throws IllegalArgumentException if any of the fields are null
     * @throws EventValidationException if the validation of the event field domains finds a problem.
     */
    public func build() throws -> MsgPackSpecificationV2.MDStatsEvent {
        try checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()
        let event = MsgPackSpecificationV2.MDStatsEvent(
                        MsgPackSpecificationV2.MDStatsEvent.API_DEFINED_MSG_TYPE,
                        iDeviceId!, iAnid!, iBssid!, iTimeStamp!, iConnectionTime!, iConnectionData!)

        try event.validate()

        return event
    }

    // throws IllegalArgumentException if any field is none
    override func checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional() throws {
        try super.checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()
        let fields : [(Any?, String)] = [
            (iConnectionTime, "ConnectionTime"),
            (iConnectionData, "ConnectionData"),
        ]
        try checkAllFields(fields: fields)
    }

    @discardableResult
    public func withConnectionTime(seconds : UInt64) -> MDStatsEventBuilder {
        iConnectionTime = seconds
        return self
    }

    @discardableResult
    public func withConnectionData(bytes : UInt64) -> MDStatsEventBuilder {
        iConnectionData = bytes
        return self
    }

    @discardableResult
    public func withConnectionData(megaBytes : Double) -> MDStatsEventBuilder {
        iConnectionData = UInt64(round(megaBytes * Double(MDStatsEventBuilder.MEGABYTES_TO_BYTES)))
        return self
    }
}
