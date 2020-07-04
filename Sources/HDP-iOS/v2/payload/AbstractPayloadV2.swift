//
//  Created by Jim Wilenius on 2020-06-17.
//

import Foundation


private let PAYLOAD_V2_MQTT_TOPIC_BASE : String = "homeos/data/v2"
private let PAYLOAD_V2_ENDPOINT_BASE : String = "/api/v2"



///
/// All subclasses of {@link AbstractPayloadV2} must register their matt topics and endpoints in the
/// holder class {@link MqttToEndpointMap}. This allows for mapping mqtt topics to endpoints.
/// <p>
/// Subclasses only define their postfix topic string and postfix endpoint strings as well as a specific IEvent type.
///
public class AbstractPayloadV2<T : IEvent> : IPayload {

    private let iEvent : T?
    private let iMqttTopic : String
    private let iEndpoint : String

    ///
    /// @param event            the event of the payload
    /// @param mqttTopicPostfix a specific topic postfix string for a subclass of {@link AbstractPayloadV2}.
    ///                         This string is possibly appended to some prefix to make the complete mqtt topic string.
    ///                         The string MUST start with '/' and must NOT end with '/'.
    /// @param endpointPostfix  the specific http endpoint path for a subclass of {@link AbstractPayloadV2}
    ///                         The string MUST start with '/', and MUST end with '/'.
    ///
    internal init(_ event : T, _ mqttTopicPostfix : String, _ endpointPostfix : String) {
        precondition(mqttTopicPostfix.hasPrefix("/"), "mqttTopicPostfix must start with /")
        precondition(endpointPostfix.hasPrefix("/"), "endpointPostfix must start with /")
        precondition(!mqttTopicPostfix.hasSuffix("/"), "mqttTopicPostfix must not end with /")
        precondition(endpointPostfix.hasSuffix("/"), "endpointPostfix must end with /")

        iEvent = Optional.some(event)
        iMqttTopic = PAYLOAD_V2_MQTT_TOPIC_BASE + mqttTopicPostfix
        iEndpoint = PAYLOAD_V2_ENDPOINT_BASE + endpointPostfix
    }

    // needed for type mapping in MqtToEndpointMap
    internal init(_ mqttTopicPostfix : String, _ endpointPostfix : String) {
        iEvent = Optional.none
        iMqttTopic = PAYLOAD_V2_MQTT_TOPIC_BASE + mqttTopicPostfix
        iEndpoint = PAYLOAD_V2_ENDPOINT_BASE + endpointPostfix
    }

    /// throws IOException
    public func toBytes() throws -> [UInt8]  {
        return try MsgPackSerializerDeserializer.toBytes(iEvent)
    }
    
    public func getEndpoint() -> String{
        return iEndpoint
    }

    public func getMqttTopic() -> String{
        return iMqttTopic
    }

    public static func name() -> String {
        return String(describing: self)
    }
    
    ///
    /// @return the prefix of all V2 mqtt topics on the format {@code some/topic/prefix}.
    /// Note the lack of starting and ending '/'
    ///
    public static func getMqttTopicPrefix() -> String {
        return PAYLOAD_V2_MQTT_TOPIC_BASE
    }

    ///
    /// @return the prefix of all V2 API endpoints on the format {@code /api/version}.
    /// Note the lack of ending '/'
    ///
    public static func getEndpointPrefix() -> String {
        return PAYLOAD_V2_ENDPOINT_BASE
    }
}
