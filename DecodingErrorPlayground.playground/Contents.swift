import Foundation

// MARK: - EXTENSIONS

extension String {
    fileprivate func repeatFor(_ times: Int) -> String {
        var newString = self

        for _ in 1..<times {
            newString += self
        }

        return newString
    }
}

extension DecodingError {
    public func debug() {
        print(divider)

        switch self {
        case .keyNotFound(let codingKey, let context): handleKeyNotFound(codingKey: codingKey, context: context)
        case .typeMismatch(_, let context): handleTypeMismatch(context: context)
        case .valueNotFound(_, let context): handleValueNotFound(context: context)
        case .dataCorrupted(let context): handleDataCorrupted(context: context)
        default: defaultHandler()
        }

        print(divider)
    }

    // MARK: - PRIVATES
    // MARK: Properties

    private var prefix: String {
        return "|||"
    }

    private var divider: String {
        return "\(prefix) ------------------"
    }

    // MARK: - Methods

    private func handleKeyNotFound(codingKey: CodingKey, context: Context) {
        print("\(prefix) DECODING ERROR: KEY NOT FOUND IN HIERARCHY")

        for (index, codingPath) in context.codingPath.enumerated() {
            print("\(prefix) \("-".repeatFor(index + 1))> \(codingPath.stringValue)")
        }
        print("\(prefix) \("-".repeatFor(context.codingPath.count + 1))> \(codingKey.stringValue)")
    }

    private func handleTypeMismatch(context: Context) {
        print("\(prefix) DECODING ERROR: TYPE MISMATCH IN HIERARCHY")

        for (index, codingPath) in context.codingPath.enumerated() {
            print("\(prefix) \("-".repeatFor(index + 1))> \(codingPath.stringValue)")
        }
        print("\(prefix) \("-".repeatFor(context.codingPath.count + 1))> \(context.debugDescription)")
    }

    private func handleValueNotFound(context: Context) {
        print("\(prefix) DECODING ERROR: VALUE NOT FOUND IN HIERARCHY")

        for (index, codingPath) in context.codingPath.enumerated() {
            print("\(prefix) \("-".repeatFor(index + 1))> \(codingPath.stringValue)")
        }
        print("\(prefix) \("-".repeatFor(context.codingPath.count + 1))> \(context.debugDescription)")
    }

    private func handleDataCorrupted(context: Context) {
        print("\(prefix) DECODING ERROR: DATA CORRUPTED")
        print("\(prefix) -> \(context.debugDescription)")

        guard let error = context.underlyingError else { return }

        print("\(prefix) -> \(error.localizedDescription)")

        if let errorMessage = (error as NSError).userInfo[NSDebugDescriptionErrorKey] {
            print("\(prefix) -> \(errorMessage)")
        }
    }

    private func defaultHandler() {
        print("\(prefix) DECODING ERROR")
        print(self)
    }
}

// MARK: - MODELS

struct View: Codable {
    let header: Header
    let footer: Footer?

    struct Header: Codable {
        let title: String
        let subtitle: String?
        let metadata: Metadata
    }

    struct Footer: Codable {
        let title: String
        let subtitle: String?
        let metadata: Metadata
    }

    struct Metadata: Codable {
        let backgroundColor: String
        let mainColor: String
        let fontName: String
        let iconURL: String
    }
}

// MARK: - JSON

let json = """
{
    "header": {
        "title": "",
        "subtitle": "",
        "metadata": {
            "backgroundColor": "",
            "mainColor": "",
            "fontName": "",
            "iconURL": ""
        }
    },
    "footer": {
        "title": "",
        "metadata": {
            "backgroundColor": "",
            "mainColor": "",
            "fontName": "",
            "iconURL": ""
        }
    }
}
""".data(using: .utf8)!

// MARK: - USING

do {
    let view = try JSONDecoder().decode(View.self, from: json)
    print(view)
} catch {
    if let error = error as? DecodingError {
        error.debug()
    }
}
