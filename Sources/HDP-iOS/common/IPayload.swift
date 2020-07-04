//
//  Created by Jim Wilenius on 2020-06-15.
//


///
/// Builds a specific payload to be put in the envelope {@link MsgPackSpecificationV1.Event}
/// See https://homeos-wbench.wesp.telekom.net/gitlab/data/hdp/blob/master/Protocols/ there may be several versions of
/// <strong>hdp-endpoint-api.yaml</strong>.
/// A Payload also knows which api endpoint to be sent to, see {@link #getEndpoint()}.
/// <p>
/// The Payload defines a byte[] representation.
///
public protocol IPayload {

    ///
    /// @return the byte array representation of msgpack payload.
    /// @throws IOException when failing to create the byte representation
    ///
    func toBytes() throws -> [UInt8]

    ///
    /// Defines the partial URL of the endpoint for a certain {@code payload}.
    /// This is where the message should be posted, as defined in the
    /// <a href="https://homeos-wbench.wesp.telekom.net/gitlab/data/hdp/blob/master/Protocols/">hdp-endpoint-api*.yaml openAPI definition</a>.
    ///
    /// @return the partial URL of the endpoint for a certain {@code payload}.
    ///
    func getEndpoint() -> String

    ///
    /// Defines the topic to use for this {@code payload}.
    /// This is where the message should be posted, as defined in the
    ///
    /// @return mqtt topic string for a certain {@code payload}.
    ///
    func getMqttTopic() -> String
}
