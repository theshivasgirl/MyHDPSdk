//
//  File.swift
//  
//
//  Created by Jim Wilenius on 2020-06-12.
//

import Foundation

///
/// Converts a 17 char long mac string to length 6 byte array.
///
/// @param macAddressString a mac address string of the format "AA:BB:CC:DD:EE:FF".
/// @return the byte array of the 6 bytes of the mac address.
/// throws IllegalArgumentException
///
public func macAddressStringToBytes(_ macAddressString: String) throws -> [UInt8] {
    try checkArgument(macAddressString.count == 17, "Malformed mac address: " + macAddressString)

    // Example 'AA:BB:CC:DD:EE:FF'
    var macAddressBytes = [UInt8](repeating: 0, count: 6)
    for i in 0 ..< macAddressBytes.count {
        let subStringStartIndex = i * 3
        let start = macAddressString.index(macAddressString.startIndex, offsetBy: subStringStartIndex)
        let end = macAddressString.index(macAddressString.startIndex, offsetBy: subStringStartIndex + 1)
        let substring = macAddressString[start...end]
        macAddressBytes[i] = UInt8(substring, radix: 16) ?? 0
    }

    return macAddressBytes;
}

///
/// Converts a 6 length byte array to mac address string representation "AA:BB:CC:DD:EE:FF".
///
/// @param bytes the size 6 array to convert.
/// @return the mac address string.
/// throws IllegalArgumentException
///
public func bytesToMacAddressString(_ bytes: [UInt8]) throws -> String {
    try checkArgument(bytes.count == 6, "Length of byte array is not 6: \(bytes.count)");
    return bytes.map({ .init(format: "%02x", $0) }).joined(separator: ":")
}

/// throws IllegalArgumentException
private func checkArgument(_ test : Bool, _ message : String) throws {
    if (!test) {
        throw IllegalArgumentException(message)
    }
}
