# DecodingErrorFormatter

This is just an extension for `DecodingError` that format its value. You can use like this:
```swift
decodingError.debug()
```

There's also a playground example where you can play around your json and check its decoding.

## DecodeError cases

### .keyNotFound

Unformatted error:

`keyNotFound(CodingKeys(stringValue: "backgroundColor", intValue: nil), Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "footer", intValue: nil), CodingKeys(stringValue: "metadata", intValue: nil)], debugDescription: "No value associated with key CodingKeys(stringValue: \"backgroundColor\", intValue: nil) (\"backgroundColor\").", underlyingError: nil))`

Formatted error:

```
||| ------------------
||| DECODING ERROR: KEY NOT FOUND IN HIERARCHY
||| -> footer
||| --> metadata
||| ---> backgroundColor
||| ------------------
```

### .typeMismatch

Unformatted error:

`typeMismatch(Swift.Int, Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "header", intValue: nil), CodingKeys(stringValue: "metadata", intValue: nil), CodingKeys(stringValue: "mainColor", intValue: nil)], debugDescription: "Expected to decode Int but found a string/data instead.", underlyingError: nil))
`

Formatted error:

```
||| ------------------
||| DECODING ERROR: TYPE MISMATCH IN HIERARCHY
||| -> header
||| --> metadata
||| ---> mainColor
||| ----> Expected to decode Int but found a string/data instead.
||| ------------------
```

### .valueNotFound

Unformatted error:

`valueNotFound(Swift.String, Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "footer", intValue: nil), CodingKeys(stringValue: "metadata", intValue: nil), CodingKeys(stringValue: "backgroundColor", intValue: nil)], debugDescription: "Expected String value but found null instead.", underlyingError: nil))
`

Formatted error:

```
||| ------------------
||| DECODING ERROR: VALUE NOT FOUND IN HIERARCHY
||| -> footer
||| --> metadata
||| ---> backgroundColor
||| ----> Expected String value but found null instead.
||| ------------------
```

### .dataCorrupted

Unformatted error:

`dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "Badly formed object around character 70." UserInfo={NSDebugDescription=Badly formed object around character 70.})))`

Formatted error:

```
||| ------------------
||| DECODING ERROR: DATA CORRUPTED:
||| -> The given data was not valid JSON.
||| -> The data couldn’t be read because it isn’t in the correct format.
||| -> Badly formed object around character 70.
||| ------------------
```
