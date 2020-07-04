//
//  Created by Jim Wilenius on 2020-06-17.
//

import Foundation

/**
 * This class is a simple holder of the map that maps mqtt topics to endpoints.
 * <p>
 * Initialize this map outside of the {@link AbstractPayloadV2} to avoid nasty deadlocks and
 * sonar complaints.
 */
public class MqttToEndpointMap {
    // Note: All subclasses must be manually registered here.
    private static let cMqttToEndpointMap : [String : String] =
        initializeLookup([PayloadDeviceTraffic.getRegisterInstance(),
                          PayloadTVMediaController.getRegisterInstance(),
                          PayloadTVScreen.getRegisterInstance(),
                          PayloadMDConnection.getRegisterInstance(),
                          PayloadMDStats.getRegisterInstance()])
    
    private init() {
    }
    
    private static func initializeLookup(_ payloads : [IPayload]) -> [String : String] {
        var map : [String : String] = [:]
        for payload in payloads {
            map[payload.getMqttTopic()] = payload.getEndpoint()
        }
        
        return map
    }
    
    /**
     * @param mqttTopic the complete topic string to get the endpoint for
     * @return the endpoint string that matches the mqttTopic, else null
     */
    public static func mqttToEndpoint(_ mqttTopic : String) -> String? {
        return cMqttToEndpointMap[mqttTopic]
    }
    
    /**
     * @return an immutable list of all mqtt topics
     */
    public static func getAllMqttTopics() -> [String] {
        return [String](cMqttToEndpointMap.keys)
    }
}
