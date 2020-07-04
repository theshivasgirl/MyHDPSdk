//
//  Created by Jim Wilenius on 2020-06-18.
//

import Foundation


/**
 * A builder for creating (v2) {@link MsgPackSpecificationV2.TVMediaControllerEvent}
 */
public class TVMediaControllerEventBuilder : TVCommonBuilder<TVMediaControllerEventBuilder> {
    var iTvPlayMode : MsgPackSpecificationV2.TVPlayMode?
    var iContentUri : String?

    /**
     * Create an empty builder
     */
    public override init() {
        super.init()
    }

    /**
     * @return MsgPackSpecificationV1.TVPlayEvent
     * @throws IllegalArgumentException if any of the fields are null
     * @throws EventValidationException if the validation of the event field domains finds a problem.
     */
    public func build() throws -> MsgPackSpecificationV2.TVMediaControllerEvent {
        try checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()
        let event = MsgPackSpecificationV2.TVMediaControllerEvent(
                        MsgPackSpecificationV2.TVMediaControllerEvent.API_DEFINED_MSG_TYPE,
                        MsgPackSpecificationV2.TVSource(iTimeStamp!, iRouterId!, iTvId!, iSnid!, iAnid!, iBssid!),
                        iTvPlayMode!, iContentUri!)

        try event.validate()

        return event
    }

    /// throws IllegalArgumentException if any of the members are Optiona.none
    override func checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional() throws {
        try super.checkAllFieldsSetSinceAPIVersion2DoesNotHandleOptional()

        let fields : [(Any?, String)] = [
            (iTvPlayMode, "TvPlayMode"),
            (iContentUri, "ContentUri"),
        ]
        try checkAllFields(fields: fields)
    }

    @discardableResult
    public func withTvPlayMode(_ mode : MsgPackSpecificationV2.TVPlayMode) -> TVMediaControllerEventBuilder {
        iTvPlayMode = mode
        return self
    }

    /**
     * @param uri a content uri
     * @return a builder of type T
     */
    @discardableResult
    public func withContentUri(_ uri : String) -> TVMediaControllerEventBuilder {
        iContentUri = uri
        return self
    }

}
