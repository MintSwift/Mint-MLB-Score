import Foundation

public protocol Provider {
    func fetch<T>(_ endpoint: EndPoint, type: T.Type) async -> T? where T: Decodable
}

public class MLBMockProvider: Provider {
    public init() {}
    public func fetch<T>(_ endpoint: EndPoint, type: T.Type) async -> T? where T : Decodable {
        do {
            if let data = response.data(using: .utf8) {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                return result
            } else {
                return nil
            }
        } catch {
            print("Error", error)
            return nil
        }
        
    }
}

public class MLBStandingMockProvider: Provider {
    public init() {}
    public func fetch<T>(_ endpoint: EndPoint, type: T.Type) async -> T? where T : Decodable {
        do {
            if let data = standingMock.data(using: .utf8) {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                return result
            } else {
                return nil
            }
        } catch {
            print("Error", error)
            return nil
        }
        
    }
}

public class MLBLiveMockProvider: Provider {
    public init() {}
    public func fetch<T>(_ endpoint: EndPoint, type: T.Type) async -> T? where T : Decodable {
        do {
            if let data = liveMock.data(using: .utf8) {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                return result
            } else {
                return nil
            }
        } catch {
            print("Error", error)
            return nil
        }
        
    }
}

public class MLBProvider: Provider {
    
    public init() {}
    
    public func fetch<T>(_ endpoint: EndPoint, type: T.Type) async -> T? where T : Decodable {
        guard let url = endpoint.url() else { return nil }
        print("StatsProvider EndPoint: \(endpoint.url()?.absoluteString ?? "nil")")
        do {
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print("StatsProvider EndPoint: \(endpoint.url()?.absoluteString ?? "nil")")
            print("StatsProvider Error: \(error)")
            return nil
        }
    }
    
    
    public static func fetch<T>(_ endpoint: EndPoint, type: T.Type) async -> T? where T: Decodable {
        guard let url = endpoint.url() else { return nil }
        do {
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print("StatsProvider EndPoint: \(endpoint.url()?.absoluteString ?? "nil")")
            print("StatsProvider Error: \(error)")
            return nil
        }
    }
}


