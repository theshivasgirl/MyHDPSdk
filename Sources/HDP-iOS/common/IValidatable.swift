//
//  Created by Jim Wilenius on 2020-06-11.
//

///
/// Implementations of the msgpack events and other POJOS should implement this interface. See v2 specification in MsgPackSpecificationV2}
/// See https://homeos-wbench.wesp.telekom.net/gitlab/data/hdp/blob/master/Protocols/ there may be several versions of hdp-endpoint-api.yaml.
///
/// A IValidatable POJO supports the validate method which will be version dependent.
/// For example see {DataValidation#validate} for the validation of v2 entities.
public protocol IValidatable {
    /// throws  EventValidationException
    func validate() throws
}
