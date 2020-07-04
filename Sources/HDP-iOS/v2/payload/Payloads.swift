//
//  Created by Jim Wilenius on 2020-06-17.
//

import Foundation


public class PayloadDeviceTraffic : AbstractPayloadV2<MsgPackSpecificationV2.DeviceTrafficEvent> {
    private static let MQTT_TOPIC : String = "/rdk"
    private static let ENDPOINT : String = "/rdk-events/"

    private init() {
        super.init(PayloadDeviceTraffic.MQTT_TOPIC, PayloadDeviceTraffic.ENDPOINT)
    }

    public static func getRegisterInstance() -> PayloadDeviceTraffic {
        return PayloadDeviceTraffic()
    }

    public init(_ event : MsgPackSpecificationV2.DeviceTrafficEvent) {
        super.init(event, PayloadDeviceTraffic.MQTT_TOPIC, PayloadDeviceTraffic.ENDPOINT)
    }
}

public class PayloadTVMediaController : AbstractPayloadV2<MsgPackSpecificationV2.TVMediaControllerEvent> {
    private static let MQTT_TOPIC : String = "/tv/media-controller"
    private static let ENDPOINT : String = "/tv-events/media-controller/"

    private init() {
        super.init(PayloadTVMediaController.MQTT_TOPIC, PayloadTVMediaController.ENDPOINT)
    }

    public static func getRegisterInstance() -> PayloadTVMediaController {
        return PayloadTVMediaController()
    }

    public init(_ event : MsgPackSpecificationV2.TVMediaControllerEvent) {
        super.init(event, PayloadTVMediaController.MQTT_TOPIC, PayloadTVMediaController.ENDPOINT)
    }
}

public class PayloadTVScreen : AbstractPayloadV2<MsgPackSpecificationV2.TVScreenEvent> {
    private static let MQTT_TOPIC : String = "/tv/screen"
    private static let ENDPOINT : String = "/tv-events/screen/"

    private init() {
        super.init(PayloadTVScreen.MQTT_TOPIC, PayloadTVScreen.ENDPOINT)
    }

    public static func getRegisterInstance() -> PayloadTVScreen {
        return PayloadTVScreen()
    }

    public init(_ event : MsgPackSpecificationV2.TVScreenEvent) {
        super.init(event, PayloadTVScreen.MQTT_TOPIC, PayloadTVScreen.ENDPOINT)
    }
}

public class PayloadMDConnection : AbstractPayloadV2<MsgPackSpecificationV2.MDConnectionEvent> {
    private static let MQTT_TOPIC : String = "/md/connection"
    private static let ENDPOINT : String = "/md-events/connection/"

    private init() {
        super.init(PayloadMDConnection.MQTT_TOPIC, PayloadMDConnection.ENDPOINT)
    }
    
    public static func getRegisterInstance() -> PayloadMDConnection {
        return PayloadMDConnection()
    }

    public init(_ event : MsgPackSpecificationV2.MDConnectionEvent) {
        super.init(event, PayloadMDConnection.MQTT_TOPIC, PayloadMDConnection.ENDPOINT)
    }
}

public class PayloadMDStats : AbstractPayloadV2<MsgPackSpecificationV2.MDStatsEvent> {
    private static let MQTT_TOPIC : String = "/md/stats"
    private static let ENDPOINT : String = "/md-events/stats/"

    private init() {
        super.init(PayloadMDStats.MQTT_TOPIC, PayloadMDStats.ENDPOINT)
    }
    
    public static func getRegisterInstance() -> PayloadMDStats {
        return PayloadMDStats()
    }

    public init(_ event : MsgPackSpecificationV2.MDStatsEvent) {
        super.init(event, PayloadMDStats.MQTT_TOPIC, PayloadMDStats.ENDPOINT)
    }
}
