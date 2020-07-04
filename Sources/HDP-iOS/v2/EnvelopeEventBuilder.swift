//
//  File.swift
//  
//
//  Created by Jim Wilenius on 2020-06-15.
//

import Foundation

///
/// The top level builder to use for constructing binary msgpacks to send to the endpoint.
/// The event builder creates the binary byte representation of the
/// {@link MsgPackSpecificationV2.Event} type that will contain the actual payload: one of the
/// payload implementations for the following events: <br>
/// For consistency, all Payloads must be sent inside the envelope
/// {@link MsgPackSpecificationV2.Event}, even if this is wasteful.<br>
/// Possible Payloads:
/// <ul>
/// <li> {@link PayloadDeviceTraffic}
/// <li> {@link PayloadTVScreen}
/// <li> {@link PayloadTVMediaController}
/// <li> {@link PayloadMDConnection}
/// <li> {@link PayloadMDStats}
/// </ul>
///
public class EnvelopeEventBuilder : IPayload {
    let iSource : String
    let iDestination : String
    let iPayload : IPayload
    var iEvent : MsgPackSpecificationV2.Event? = nil

    ///
    /// @param source      non-optional source string
    /// @param destination non-optional destination string
    /// @param payload     non-optional {@link IPayload}
    ///
    public init(_ source : String, _ destination : String, _ payload : IPayload) {
        iPayload = payload
        iSource = source
        iDestination = destination
    }

    /// throws IOException,  EventValidationException
    public func toBytes() throws -> [UInt8] {
        return try MsgPackSerializerDeserializer.toBytes(build())
    }

    /// throws IOException, EventValidationException
    public func build() throws -> MsgPackSpecificationV2.Event {
        if (iEvent == nil) {
            let payload = try iPayload.toBytes()
            iEvent = MsgPackSpecificationV2.Event(MsgPackSpecificationV2.Event.API_DEFINED_MSG_TYPE,
                                                  "msgpack", iSource, iDestination, payload)
            try iEvent!.validate()
        }

        return iEvent!
    }

    ///
    /// @return the partial URL of the endpoint for a certain {@code payload} as defined by the {@link IPayload#getEndpoint()} for this {@link EnvelopeEventBuilder}.
    ///
    public func getEndpoint() -> String {
        return iPayload.getEndpoint()
    }

    ///
    /// @return the mqtt topic for a certain {@code payload} as defined by the {@link IPayload#getMqttTopic()} for this {@link EnvelopeEventBuilder}.
    ///
    public func getMqttTopic() -> String {
        return iPayload.getMqttTopic()
    }
}


