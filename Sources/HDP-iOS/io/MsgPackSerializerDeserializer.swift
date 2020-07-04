//
//  Created by Jim Wilenius on 2020-06-15.
//

import Foundation
//import MessagePacker
import MessagePack

///
/// This class handles serialization and deserialization of msgpack data.
/// It is a simple wrapper of an {@link ObjectMapper} which is thread safe.
///
enum MsgPackSerializerDeserializer {   

    /// @param rawData a byte array that is assumed to be msgpack data according to the specification id
    /// https://homeos-wbench.wesp.telekom.net/gitlab/data/hdp/blob/master/Protocols/
    /// hdp-endpoint-api-v*.yaml
    /// @param clazz   of type T
    /// @param <T>     type of clazz, the type to parse into
    /// @return an instance of T filled with data from {@code rawData}
    /// @throws IOException when parsing fails
    ///
    public static func valueOf<T : Decodable>(_ rawData : [UInt8]) throws -> T {
        do {
            let decoder : MessagePackDecoder = MessagePackDecoder()
            let decoded : T = try decoder.decode(T.self, from: Data(rawData))
            return decoded
        } catch let e as DecodingError {
            throw IOException("Could not decode rawData to \(String(describing: T.self))! :  \(String(describing: e))")
        } catch let e {
            throw IOException("Could not decode rawData to \(String(describing: T.self))! :  \(String(describing: e))")
        }
    }
    
    // throws IOException
    public static func toBytes<T : Encodable>(_ toSerialize : T) throws -> [UInt8] {
        do {
            let data : Data = try MessagePackEncoder().encode(toSerialize)
            return [UInt8](data)
        } catch {
            throw IOException("Could not encode to msgpack!")
        }
    }
}
