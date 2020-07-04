import Foundation

public enum MsgPackSpecificationV2 {
    
    public class Event : IEvent, IValidatable {
        public static let API_DEFINED_MSG_TYPE : Int = 4
        
        public let msg_type : Int
        public let content_type : String
        public let source : String
        public let dest : String
        public let payload : Array<UInt8>
        
        public init(
            _ msg_type : Int,
            _ content_type : String,
            _ source : String,
            _ dest : String,
            _ payload : Array<UInt8>
        ) {
            self.msg_type = msg_type
            self.content_type = content_type
            self.source = source
            self.dest = dest
            self.payload = payload
        }
    }
    
    public class DeviceTrafficEvent : IEvent, IValidatable {
        public let msg_type : Int
        public let timestamp : TimeStamp
        public let router_id : RouterId
        public let device_id : Array<UInt8>
        public let signalStrength : Int
        public let authenticationState : Bool
        public let active : Bool
        public let packetsSent : Int64
        public let packetsReceived : Int64
        
        public static let API_DEFINED_MSG_TYPE : Int = 1;
        
        public init(
            _ msg_type : Int,
            _ timestamp : TimeStamp,
            _ router_id : RouterId,
            _ device_id : Array<UInt8>,
            _ signalStrength : Int,
            _ authenticationState : Bool,
            _ active : Bool,
            _ packetsSent : Int64,
            _ packetsReceived : Int64
        ) {
            self.msg_type = msg_type
            self.timestamp = timestamp
            self.router_id = router_id
            self.device_id = device_id
            self.signalStrength = signalStrength
            self.authenticationState = authenticationState
            self.active = active
            self.packetsSent = packetsSent
            self.packetsReceived = packetsReceived
        }
    }
    
    public class TVScreenEvent : IEvent, IValidatable {
        public let msg_type : Int
        public let source : TVSource
        public let screenActive : Bool
        
        public static let API_DEFINED_MSG_TYPE : Int = 12;
        
        public init(
            _ msg_type : Int,
            _ source : TVSource,
            _ screenActive : Bool
        ){
            self.msg_type = msg_type
            self.source = source
            self.screenActive = screenActive
        }
    }
    
    public class TVMediaControllerEvent : IEvent, IValidatable {
        public let msg_type : Int
        public let source : TVSource
        public let mode : TVPlayMode
        public let content_uri : String
        
        public static let API_DEFINED_MSG_TYPE : Int = 13;
        
        public init(
            _ msg_type : Int,
            _ source : TVSource,
            _ mode : TVPlayMode,
            _ content_uri : String
        ){
            self.msg_type = msg_type
            self.source = source
            self.mode = mode
            self.content_uri = content_uri
        }
        
    }
    
    public enum RouterId : IValidatable, Codable, Equatable {
        case routerMac([UInt8])
        case routerId(String)

        public func getAsString() -> String? {
            switch self {
            case .routerId(let id):
                return Optional.some(id)
            default:
                return Optional.none
            }
        }

        public func getAsBytes() -> [UInt8]? {
            switch self {
            case .routerMac(let mac):
                return Optional.some(mac)
            default:
                return Optional.none
            }
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            do {
                self = .routerMac(try container.decode([UInt8].self))
            } catch DecodingError.typeMismatch {
                self = .routerId(try container.decode(String.self))
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .routerMac(let value):
                try container.encode(value)
            case .routerId(let value):
                try container.encode(value)
            }
        }
    }
    
    public class TVSource : IValidatable, Codable {
        public let timestamp : TimeStamp
        public let router_id : RouterId
        public let tv_id : Array<UInt8>
        public let snid : String
        public let anid : String
        public let bssid : Array<UInt8>
        
        public init(
            _ timestamp : TimeStamp,
            _ router_id : RouterId,
            _ tv_id : Array<UInt8>,
            _ snid : String,
            _ anid : String,
            _ bssid : Array<UInt8>
        ){
            self.timestamp = timestamp
            self.router_id = router_id
            self.tv_id = tv_id
            self.snid = snid
            self.anid = anid
            self.bssid = bssid
        }
    }
    
    public struct TimeStamp : IValidatable, Codable, Equatable {
        public let seconds : UInt64
        public let nanos : Int
        
        public init(
            _ seconds : UInt64,
            _ nanos : Int
        ){
            self.seconds = seconds
            self.nanos = nanos
        }
    }
    
    public enum TVPlayMode : String, Codable, CaseIterable {
        case play
        case stop
        case pause
        case next
        case previous
        case forward
        case rewind
        case record
    }

    public class MDConnectionEvent : IEvent, IValidatable, Codable {
        public let msg_type : Int
        public let device_id : Array<UInt8>
        public let anid : String
        public let bssid : Array<UInt8>
        public let timestamp : TimeStamp
        public let wifi_connected : Bool
        public let connection_class : Int
        
        public static let API_DEFINED_MSG_TYPE : Int = 30
        
        public init(
            _ msg_type : Int,
            _ device_id : Array<UInt8>,
            _ anid : String,
            _ bssid : Array<UInt8>,
            _ timestamp : TimeStamp,
            _ wifi_connected : Bool,
            _ connection_class : Int
        ){
            self.msg_type = msg_type
            self.device_id = device_id
            self.anid = anid
            self.bssid = bssid
            self.timestamp = timestamp
            self.wifi_connected = wifi_connected
            self.connection_class = connection_class
        }
    }
    
    public class MDStatsEvent : IEvent, IValidatable, Codable {
        public let msg_type : Int
        public let device_id : Array<UInt8>
        public let anid : String
        public let bssid : Array<UInt8>
        public let timestamp : TimeStamp
        public let connection_time : UInt64
        public let connection_data : UInt64
        
        public static let API_DEFINED_MSG_TYPE : Int = 31
        
        public init(
            _ msg_type : Int,
            _ device_id : Array<UInt8>,
            _ anid : String,
            _ bssid : Array<UInt8>,
            _ timestamp : TimeStamp,
            _ connection_time : UInt64,
            _ connection_data : UInt64
        ){
            self.msg_type = msg_type
            self.device_id = device_id
            self.anid = anid
            self.bssid = bssid
            self.timestamp = timestamp
            self.connection_time = connection_time
            self.connection_data = connection_data
        }
    }
}
