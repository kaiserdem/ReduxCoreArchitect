
import ReduxCore
import SwiftUI
import Dependencies

protocol TitlesApi {
    func getTitles(withId: String) async throws -> TitlesData
}

enum TitlesApiKey: DependencyKey {
    static let liveValue: TitlesApi = TitlesEffect()
}

extension DependencyValues {
    var titlesEffect: TitlesApi {
        get { self[TitlesApiKey.self] }
        set { self[TitlesApiKey.self] = newValue }
    }
}

struct TitlesEffect: TitlesApi {
    func getTitles(withId: String) async throws -> TitlesData {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(withId)") else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let titleData = try JSONDecoder().decode(TitlesData.self, from: data)
            
            return titleData
            
        } catch {
            throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "Failed data"])
        }
        
    }
}
