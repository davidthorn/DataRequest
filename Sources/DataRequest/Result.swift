public enum Result<T> {
    case success(T)
    case fail(Error)

    var value: T? {
        switch self {
            case .success(let result): return result
            default: return nil
        }
    }
}