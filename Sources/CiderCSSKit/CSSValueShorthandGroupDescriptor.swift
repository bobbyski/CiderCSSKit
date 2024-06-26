public struct CSSValueShorthandGroupDescriptor {

    public let subAttributeName: String
    public let optional: Bool
    public let afterSeparator: Bool
    public let defaultValue: CSSValue?

    public init(subAttributeName: String, optional: Bool = false, afterSeparator: Bool = false, defaultValue: CSSValue? = nil) {
        self.subAttributeName = subAttributeName
        self.optional = optional
        self.afterSeparator = afterSeparator
        self.defaultValue = defaultValue
    }

    func matches(values: [CSSValue], from index: inout Int, _ validationConfiguration: CSSValidationConfiguration) -> Bool {
        if afterSeparator {
            if values[index] != .separator {
                return false
            }
            index += 1
        }

        guard let groupingType = validationConfiguration.valueGroupingTypeByAttribute[subAttributeName] else {
            return false
        }

        switch groupingType {
        case let .single(types):
            if CSSValueGroupingType.matches(single: values[index], types) {
                index += 1
                return true
            }

        case let .multiple(types, minValueCount, maxValueCount, _):
            var testValues: [CSSValue]
            if let maxValueCount {
                let valueCount = min(maxValueCount, values.count - index)
                testValues = [CSSValue](values[index..<index + valueCount])
            }
            else {
                testValues = [CSSValue](values[index..<values.count])
            }
            if let matchingCount = CSSValueGroupingType.matches(multiple: testValues, types, minValueCount, maxValueCount, loose: true) {
                index += matchingCount
                return true
            }

        case let .sequence(types):
            let valueCount = min(types.count, values.count - index)
            let testValues = [CSSValue](values[index..<index + valueCount])
            if CSSValueGroupingType.matches(sequence: testValues, types) {
                index += types.count
                return true
            }

        default:
            break
        }

        return false
    }

}
