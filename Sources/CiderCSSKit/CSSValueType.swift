public enum CSSValueType: Equatable {
    
    case angle
    case color
    case keyword(String)
    case length(CSSLengthUnit? = nil)
    case number
    case percentage
    case separator
    case string
    case url

    func isEqual(to other: CSSValueType, fully: Bool) -> Bool {
        switch self {
        case .angle, .color, .number, .percentage, .separator, .string, .url:
            return self == other
        case let .keyword(expectedKeyword):
            if case let .keyword(testedKeyword) = other {
                return !fully || expectedKeyword == testedKeyword
            }
        case let .length(expectedUnit):
            if case let .length(testedUnit) = other {
                return !fully || expectedUnit == testedUnit
            }
        }
        
        return false
    }
    
    func matches(value: CSSValue) -> Bool {
        switch self {
        case .angle:
            if case .angle = value {
                return true
            }
            
        case .color:
            if case .color = value {
                return true
            }
            
        case let .keyword(expectedKeywords):
            if case let .keyword(valueKeyword) = value, expectedKeywords.contains(valueKeyword) {
                return true
            }

        case let .length(expectedUnit):
            if case let .length(_, valueUnit) = value {
                return expectedUnit == nil || expectedUnit! == valueUnit
            }
            
        case .number:
            if case .number = value {
                return true
            }
            
        case .percentage:
            if case .percentage = value {
                return true
            }
            
        case .separator:
            if case .separator = value {
                return true
            }
            
        case .string:
            if case .string = value {
                return true
            }
            
        case .url:
            if case .url = value {
                return true
            }
        }
        
        return false
    }
    
}
