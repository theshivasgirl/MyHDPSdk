//
//  Created by Jim Wilenius on 2020-06-11.
//

import Foundation

///
/// Definitions and extension for validation of the POJOs defined in the https://homeos-wbench.wesp.telekom.net/gitlab/data/hdp/blob/master/Protocols/hdp-endpoint-api-v2.yaml
///

extension MsgPackSpecificationV2.Event {
    /// throws EventValidationException
    public func validate() throws {
        try validateMsgType(MsgPackSpecificationV2.Event.API_DEFINED_MSG_TYPE, self.msg_type, String(describing: MsgPackSpecificationV2.Event.self))
        try fieldNotOptional(self.content_type, "content_type not optional.")
        try fieldNotOptional(self.source, "source not optional.")
        try fieldNotOptional(self.dest,  "dest not optional.")
        try throwIfFalse("msgpack" == self.content_type, "content_type must be 'msgpack'. Found: " + self.content_type)
    }
}


extension MsgPackSpecificationV2.DeviceTrafficEvent {
    /// throws EventValidationException
    public func validate() throws {
        try validateMsgType(MsgPackSpecificationV2.DeviceTrafficEvent.API_DEFINED_MSG_TYPE, self.msg_type, String(describing: MsgPackSpecificationV2.DeviceTrafficEvent.self))
        try self.timestamp.validate()
        try self.router_id.validate()
        try validateMacAddress(self.device_id, "device_id")
        
        try fieldNotOptional(self.signalStrength, "SignalStrength is not optional")
        try fieldNotOptional(self.packetsSent, "PacketsSent is not optional")
        try fieldNotOptional(self.packetsReceived, "PacketsReceived is not optional")
        
        try throwIfFalse(-200 <= self.signalStrength && self.signalStrength <= 0, "signalStrength out of bounds: \(self.signalStrength)")
        try throwIfFalse(self.packetsSent >= 0, "packetsSent out of bounds: \(self.packetsSent)")
        try throwIfFalse(self.packetsReceived >= 0, "packetsReceived out of bounds: \(self.packetsReceived)")
    }
}

extension MsgPackSpecificationV2.TVScreenEvent {
    /// throws EventValidationException
    public func validate() throws {
        try validateMsgType(MsgPackSpecificationV2.TVScreenEvent.API_DEFINED_MSG_TYPE, self.msg_type, String(describing: MsgPackSpecificationV2.TVScreenEvent.self))
        try fieldNotOptional(self.source, "source is not optional.")
        try self.source.validate()
        try fieldNotOptional(self.screenActive, "screenActive is not optional.")
    }
}

extension MsgPackSpecificationV2.TVMediaControllerEvent {
    /// throws EventValidationException
    public func validate() throws {
        try validateMsgType(MsgPackSpecificationV2.TVMediaControllerEvent.API_DEFINED_MSG_TYPE, self.msg_type, String(describing: MsgPackSpecificationV2.TVMediaControllerEvent.self))
        
        try fieldNotOptional(self.source, "source is not optional.")
        try fieldNotOptional(self.mode, "mode is not optional.")
        try fieldNotOptional(self.content_uri, "content_uri is not optional.")
        
        try self.source.validate()
        try validateUri(self.content_uri)
    }
    
}

extension MsgPackSpecificationV2.TVSource {
    /// throws EventValidationException
    public func validate() throws {
        try fieldNotOptional(self.timestamp, "timestamp is not optional.")
        try self.timestamp.validate()
        try self.router_id.validate()
        try validateMacAddress(self.tv_id, "tv_id")
        try validateSnid(self.snid)
        try validateAnid(self.anid)
        try validateMacAddress(self.bssid, "bssid")
    }
}

extension MsgPackSpecificationV2.TimeStamp {
    /// throws EventValidationException
    public func validate() throws {
        try throwIfFalse(self.seconds >= 0, "timestamp seconds must be >= 0.")
        try throwIfFalse(self.nanos >= 0, "timestamp nanos must be >= 0.")
    }
}

extension MsgPackSpecificationV2.MDConnectionEvent {
    /// throws EventValidationException
    public func validate() throws {
        try validateMsgType(MsgPackSpecificationV2.MDConnectionEvent.API_DEFINED_MSG_TYPE, self.msg_type, String(describing: MsgPackSpecificationV2.MDConnectionEvent.self))
        
        try validateMacAddress(self.device_id, "device_id")
        try self.timestamp.validate()
        try fieldNotOptional(self.wifi_connected, "wifi_connected is not optional")
        
        try fieldNotOptional(self.connection_class, "connection_class is not optional")
        try throwIfFalse((self.connection_class >= 0 && self.connection_class <= 6), "connection_class out of bounds: \(self.connection_class)")
    }
}

extension MsgPackSpecificationV2.MDStatsEvent {
    /// throws EventValidationException
    public func validate() throws {
        try validateMsgType(MsgPackSpecificationV2.MDStatsEvent.API_DEFINED_MSG_TYPE, self.msg_type, String(describing: MsgPackSpecificationV2.MDStatsEvent.self))
        
        try validateMacAddress(self.device_id, "device_id")
        try self.timestamp.validate()
        
        try fieldNotOptional(self.connection_time, "connection_time is not optional")
        try throwIfFalse(self.connection_time >= 0, "connection_time out of bounds: \(self.connection_time)")
        
        try fieldNotOptional(self.connection_data, "connection_data is not optional")
        try throwIfFalse((self.connection_data >= 0), "connection_data out of bounds: \(self.connection_data)")
    }
}


extension MsgPackSpecificationV2.RouterId {
    /// throws EventValidationException
    public func validate() throws {
        switch self {
        case let .routerMac(routerIdArray):
            try validateMacAddress(routerIdArray, "router_id")
            return
        case let .routerId(routerIdString):
            try validateStringLengthLessThanOrEqual(routerIdString, "router_id", 128)
            return
        }        
    }
}

//---------

/// throws EventValidationException
public func validateMacAddress(_ macAddress: [UInt8], _ fieldName : String) throws {
    try fieldNotOptional(macAddress, "macAddress is not optional.")
    
    if (macAddress.count != 6) {
        throw EventValidationException(fieldName + ": macAddress must be of length 6. found: \(macAddress.count)")
    }
}

/// throws EventValidationException
public func validateAnid(_ anid : String) throws {
    try fieldNotOptional(anid, "anid is not optional.")
    try validateStringLengthExact(anid, "anid", [24])
    try validateNumericString(anid, "anid")
}

/// throws EventValidationException
public func validateSnid(_ snid : String) throws {
    try fieldNotOptional(snid, "snid is not optional.")
    try validateStringLengthLessThanOrEqual(snid, "snid", 128)
}
