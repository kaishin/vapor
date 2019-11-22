#if !canImport(ObjectiveC)
import XCTest

extension ApplicationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ApplicationTests = [
        ("testAnyResponse", testAnyResponse),
        ("testApplicationStop", testApplicationStop),
        ("testAsyncKitExport", testAsyncKitExport),
        ("testBoilerplate", testBoilerplate),
        ("testBoilerplateClient", testBoilerplateClient),
        ("testChangeRequestLogLevel", testChangeRequestLogLevel),
        ("testClientBeforeSend", testClientBeforeSend),
        ("testComplexContent", testComplexContent),
        ("testContent", testContent),
        ("testContentContainer", testContentContainer),
        ("testCustomEncode", testCustomEncode),
        ("testDotEnvRead", testDotEnvRead),
        ("testEnumResponse", testEnumResponse),
        ("testGH1534", testGH1534),
        ("testGH1609", testGH1609),
        ("testGH1787", testGH1787),
        ("testHeadRequest", testHeadRequest),
        ("testInvalidCookie", testInvalidCookie),
        ("testJSON", testJSON),
        ("testLiveServer", testLiveServer),
        ("testMiddlewareOrder", testMiddlewareOrder),
        ("testMissingBody", testMissingBody),
        ("testMultipartDecode", testMultipartDecode),
        ("testMultipartEncode", testMultipartEncode),
        ("testParameter", testParameter),
        ("testPortOverride", testPortOverride),
        ("testQuery", testQuery),
        ("testQueryGet", testQueryGet),
        ("testQueryStringRunning", testQueryStringRunning),
        ("testRequestQueryStringPercentEncoding", testRequestQueryStringPercentEncoding),
        ("testResponseEncodableStatus", testResponseEncodableStatus),
        ("testRootGet", testRootGet),
        ("testSessionDestroy", testSessionDestroy),
        ("testStreamFile", testStreamFile),
        ("testStreamFileConnectionClose", testStreamFileConnectionClose),
        ("testSwiftError", testSwiftError),
        ("testURLEncodedFormDecode", testURLEncodedFormDecode),
        ("testURLEncodedFormDecodeQuery", testURLEncodedFormDecodeQuery),
        ("testURLEncodedFormEncode", testURLEncodedFormEncode),
        ("testValidationError", testValidationError),
        ("testVaporProvider", testVaporProvider),
        ("testVaporURI", testVaporURI),
        ("testViewResponse", testViewResponse),
        ("testWebSocket404", testWebSocket404),
        ("testWebSocketClient", testWebSocketClient),
        ("testWebSocketServer", testWebSocketServer),
    ]
}

extension AuthenticationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__AuthenticationTests = [
        ("testBasicAuthenticator", testBasicAuthenticator),
        ("testBearerAuthenticator", testBearerAuthenticator),
        ("testMiddlewareConfigExistential", testMiddlewareConfigExistential),
        ("testSessionAuthentication", testSessionAuthentication),
    ]
}

extension BCryptTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BCryptTests = [
        ("testFail", testFail),
        ("testInvalidMaxCost", testInvalidMaxCost),
        ("testInvalidMinCost", testInvalidMinCost),
        ("testInvalidSalt", testInvalidSalt),
        ("testOnlineVapor", testOnlineVapor),
        ("testVerify", testVerify),
        ("testVersion", testVersion),
    ]
}

extension URLEncodedFormTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__URLEncodedFormTests = [
        ("testArray", testArray),
        ("testBasic", testBasic),
        ("testBasicWithAmpersand", testBasicWithAmpersand),
        ("testCodable", testCodable),
        ("testDecode", testDecode),
        ("testDecodeIntArray", testDecodeIntArray),
        ("testDictionary", testDictionary),
        ("testEncode", testEncode),
        ("testGH3", testGH3),
        ("testNested", testNested),
        ("testNestedParsing", testNestedParsing),
        ("testOptions", testOptions),
        ("testPercentDecoding", testPercentDecoding),
        ("testPercentEncoding", testPercentEncoding),
        ("testPercentEncodingSpecial", testPercentEncodingSpecial),
        ("testPercentEncodingWithAmpersand", testPercentEncodingWithAmpersand),
        ("testRawEnum", testRawEnum),
    ]
}

extension ValidationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ValidationTests = [
        ("testAlphanumeric", testAlphanumeric),
        ("testASCII", testASCII),
        ("testCatchError", testCatchError),
        ("testCountCharacters", testCountCharacters),
        ("testCountItems", testCountItems),
        ("testDoubleNegationIsAvoided", testDoubleNegationIsAvoided),
        ("testEmail", testEmail),
        ("testEmpty", testEmpty),
        ("testPreexistingValidatorResultIsIncluded", testPreexistingValidatorResultIsIncluded),
        ("testRange", testRange),
        ("testURL", testURL),
        ("testValidate", testValidate),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ApplicationTests.__allTests__ApplicationTests),
        testCase(AuthenticationTests.__allTests__AuthenticationTests),
        testCase(BCryptTests.__allTests__BCryptTests),
        testCase(URLEncodedFormTests.__allTests__URLEncodedFormTests),
        testCase(ValidationTests.__allTests__ValidationTests),
    ]
}
#endif
