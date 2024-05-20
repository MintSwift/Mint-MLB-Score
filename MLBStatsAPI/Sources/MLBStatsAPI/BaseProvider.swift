// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public struct Provider {
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
