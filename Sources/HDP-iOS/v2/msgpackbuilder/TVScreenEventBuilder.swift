//
//  Created by Jim Wilenius on 2020-06-18.
//

import Foundation


/**
 * A builder for creating (v2) {@link MsgPackSpecificationV2.TVScreenEvent}
 */
public class TVScreenEventBuilder : TVCommonBuilder<TVScreenEventBuilder> {
    var iScreenActive : Bool?

    /**
     * Create an empty builder
     */
    public override init() {
        super.init()
    }

    /**
     * @return MsgPackSpecificationV1.TVScreenEvent
     * @throws IllegalArgumentException if any of the fields are null
     * @throws EventValidationException if the validation of the event field domains finds a problem.
     */
    public func build() throws -> MsgPackSpecificationV2.TVScreenEvent{
        try checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()
        let event = MsgPackSpecificationV2.TVScreenEvent(
                        MsgPackSpecificationV2.TVScreenEvent.API_DEFINED_MSG_TYPE,
                        MsgPackSpecificationV2.TVSource(iTimeStamp!, iRouterId!, iTvId!, iSnid!, iAnid!, iBssid!),
                        iScreenActive!)

        try event.validate()

        return event
    }

    /// throws IllegalArgumentException if any of the fields are null
    override func checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional() throws {
        try super.checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()

        let fields : [(Any?, String)] = [
            (iScreenActive, "ScreenActive"),
        ]
        try checkAllFields(fields: fields)
    }

    /**
     * @param bssid a byte array of size 6
     * @return a builder of type T
     */
    @discardableResult
    public func withScreenActive(_ state : Bool ) -> TVScreenEventBuilder {
        iScreenActive = state
        return self
    }
}
