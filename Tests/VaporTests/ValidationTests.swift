import Vapor
import XCTest

extension Validator.CharacterSet.Failure: CustomStringConvertible {
    public var description: String {
        "contains an invalid character: '!' (allowed: A-Z, a-z, 0-9)"
    }
}

class ValidationTests: XCTestCase {
    func testValidate() throws {
        let valid = """
        {
            "name": "Tanner",
            "age": 24,
            "email": "me@tanner.xyz",
            "luckyNumber": 5,
            "profilePictureURL": "https://foo.jpg",
            "preferredColors": ["blue"],
            "pet": {
                "name": "Zizek",
                "age": 3
            }
        }
        """
        try User.validate(json: valid)
        let invalid = """
        {
            "name": "Tan!ner",
            "age": 24,
            "email": "me@tanner.xyz",
            "luckyNumber": 5,
            "profilePictureURL": "https://foo.jpg",
            "preferredColors": ["blue"],
            "pet": {
                "name": "Zizek",
                "age": 3
            }
        }
        """
        XCTAssertThrowsError(try User.validate(json: invalid)) { error in
            guard let validationsError = error as? ValidationsError else {
                XCTFail("error is not of type ValidationsError")
                return
            }
            XCTAssertEqual(validationsError.description, "name: contains an invalid character: '!' (allowed: A-Z, a-z, 0-9)")
        }
    }

    func testASCII() throws {
        XCTAssertNil(Validator<String>.ascii.validate("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))
        XCTAssertNil(Validator<String>.ascii.validate("\n\r\t"))
        XCTAssertNotNil(Validator<String>.ascii.validate("\n\r\t\u{129}"))
        XCTAssertNil(Validator<String>.ascii.validate(" !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"))
        XCTAssertNotNil(Validator<String>.ascii.validate("ABCDEFGHIJKLMNOPQR🤠STUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"))
    }

    func testAlphanumeric() throws {
        XCTAssertNil(Validator<String>.alphanumeric.validate("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))
        XCTAssertNotNil(Validator<String>.alphanumeric.validate("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"))
    }

    func testEmpty() throws {
        XCTAssertNil(Validator<String>.empty.validate(""))
        XCTAssertNotNil(Validator<String>.empty.validate("something"))
        XCTAssertNil(Validator<[Int]>.empty.validate([]))
        XCTAssertNotNil(Validator<[Int]>.empty.validate([1, 2]))
    }

    func testEmail() throws {
        XCTAssertNil(Validator<String>.email.validate("tanner@vapor.codes"))
        XCTAssertNotNil(Validator<String>.email.validate("tanner@vapor.codestanner@vapor.codes"))
        XCTAssertNotNil(Validator<String>.email.validate("tanner@vapor.codes."))
        XCTAssertNotNil(Validator<String>.email.validate("tanner@@vapor.codes"))
        XCTAssertNotNil(Validator<String>.email.validate("@vapor.codes"))
        XCTAssertNotNil(Validator<String>.email.validate("tanner@codes"))
        XCTAssertNotNil(Validator<String>.email.validate("asdf"))
    }
    
    func testRange() throws {
        XCTAssertNil(Validator<Int>.range(-5...5).validate(4))
        XCTAssertNil(Validator<Int>.range(-5...5).validate(5))
        XCTAssertNil(Validator<Int>.range(-5...5).validate(-5))
        XCTAssertNotNil(Validator<Int>.range(-5...5).validate(6))
        XCTAssertNotNil(Validator<Int>.range(-5...5).validate(-6))
        XCTAssertNil(Validator<Int>.range(5...).validate(.max))
        XCTAssertNil(Validator<Int>.range(-5..<6).validate(-5))
        XCTAssertNil(Validator<Int>.range(-5..<6).validate(-4))
        XCTAssertNil(Validator<Int>.range(-5..<6).validate(5))
        XCTAssertNotNil(Validator<Int>.range(-5..<6).validate(-6))
        XCTAssertNotNil(Validator<Int>.range(-5..<6).validate(6))
    }

    func testCountCharacters() throws {
        let validator = Validator<String>.count(1...6)
        XCTAssertNil(validator.validate("1"))
        XCTAssertNil(validator.validate("123"))
        XCTAssertNil(validator.validate("123456"))
        XCTAssertNotNil(validator.validate(""))
        XCTAssertNotNil(validator.validate("1234567"))
    }

    func testCountItems() throws {
        let validator = Validator<[Int]>.count(1...6)
        XCTAssertNil(validator.validate([1]))
        XCTAssertNil(validator.validate([1, 2, 3]))
        XCTAssertNil(validator.validate([1, 2, 3, 4, 5, 6]))
        XCTAssertNotNil(validator.validate([]))
        XCTAssertNotNil(validator.validate([1, 2, 3, 4, 5, 6, 7]))
    }

    func testURL() throws {
        XCTAssertNil(Validator<String>.url.validate("https://www.somedomain.com/somepath.png"))
        XCTAssertNil(Validator<String>.url.validate("https://www.somedomain.com/"))
        XCTAssertNil(Validator<String>.url.validate("file:///Users/vapor/rocks/somePath.png"))
        XCTAssertNotNil(Validator<String>.url.validate("www.somedomain.com/"))
        XCTAssertNotNil(Validator<String>.url.validate("bananas"))
    }
}

private final class User: Validatable, Codable {
    var id: Int?
    var name: String
    var age: Int
    var email: String?
    var pet: Pet
    var luckyNumber: Int?
    var profilePictureURL: String?
    var preferredColors: [String]
    
    struct Pet: Codable {
        var name: String
        var age: Int
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }

    init(id: Int? = nil, name: String, age: Int, pet: Pet, preferredColors: [String] = []) {
        self.id = id
        self.name = name
        self.age = age
        self.pet = pet
        self.preferredColors = preferredColors
    }

    static func validations() -> [Validation] {
        [
            // validate name is at least 5 characters and alphanumeric
            Validation(key: "name", as: String.self, validator: .count(5...) && .alphanumeric),
            // validate age is 18 or older
            Validation(key: "age", as: Int.self, validator: .range(18...)),
            // validate the email is valid and is not nil
//            Validation(key: "email", as: String?.self, validator: !.nil && .email),
//            Validation(key: "email", as: String?.self, validator: .email && !.nil), // test other way
            // validate the email is valid or is nil
            Validation(key: "email", as: String?.self, validator: .nil || .email),
            Validation(key: "email", as: String?.self, validator: .email || .nil), // test other way
            // validate that the lucky number is nil or is 5 or 7
            Validation(key: "luckyNumber", as: Int?.self, validator: .nil || .in(5, 7)),
            // validate that the profile picture is nil or a valid URL
            Validation(key: "profilePictureURL", as: String?.self, validator: .url || .nil),
//            Validation(key: "preferredColors", as: [String].self, validator: !.empty),
            // pet validations
            Validation(key: "pet", validations: [
                Validation(key: "name", as: String.self, validator: .count(5...) && .characterSet(.alphanumerics + .whitespaces)),
                Validation(key: "age", as: Int.self, validator: .range(3...))
            ])
        ]
    }
}
