//
//  Created by Jim Wilenius on 2020-06-12.
//  This is common to validation for any version
//
import CoreFoundation


public protocol AbstractDataValidation {
    /// throws  EventValidationException
    func validate(_ validatable : IValidatable) throws
}


/// throws EventValidationException
public func throwIfFalse(_ expression : Bool, _ message : String) throws {
    if (!expression) {
        throw EventValidationException("Validation failed: " + message);
    }
}

// This is for documentational purposes since swift does not contain null pointers like Java does.
/// throws EventValidationException
public func fieldNotOptional(_ optionalField : Any?, _ message : String) throws {
    if (optionalField == nil) {
        throw EventValidationException("Validation failed: " + message);
    }
}

/// throws EventValidationException
public func validateMsgType(_ expectedMsgType : Int, _ msgType : Int, _ className : String) throws {
    if (msgType != expectedMsgType) {
        throw EventValidationException("Unexpected msg_type value (\(msgType)). Expected \(expectedMsgType), the type for \(className)");
    }
}

/// throws EventValidationException
public func validateStringLengthLessThanOrEqual(_ idString : String, _ typeName : String, _ acceptedLength : Int) throws {
    let actualLength = idString.count
    let isAccepted = actualLength <= acceptedLength
    if (!isAccepted) {
        throw EventValidationException("\(typeName) as String must be of length at most: \(acceptedLength). Has length=\(actualLength)");
    }
}

/// throws EventValidationException
public func validateStringLengthExact(_ idString : String, _ typeName : String, _ acceptedLengths : [Int]) throws {
    let actualLength = idString.count
    let isAccepted = acceptedLengths.contains(where: {acceptedLength in return acceptedLength == actualLength});
    if (!isAccepted) {
        throw EventValidationException("\(typeName) as String must be of length(s): \(acceptedLengths.map(String.init).joined(separator: ", ")). Has length=\(actualLength)");
    }
}

/// throws EventValidationException
public func validateNumericString(_ idString : String, _ typeName : String) throws {
    for c in idString {
        if (!c.isNumber) {
            throw EventValidationException("\(typeName) as String must be only numeric, [0..9].");
        }
    }
}

/// throws EventValidationException
public func validateUri(_ uri : String) throws {
    //TODO there does not seem to exist any way of doing this other than writing it myself...
}
