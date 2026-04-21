//
//  MainViewModel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 27/02/2026.
//
import Foundation
import SwiftUI
import SkipFuse

// SKIP @bridgeMembers
@MainActor
@Observable
public class MainViewModel {

    public var state: AppConstants.PageState = .loading

    public init() {}

    public func getData(for path: UrlPath) async {

        let finalUrlString = AppConstants.EndPoints.test + path.rawValue

        guard let url = URL(string: finalUrlString) else {
            state = .error(ApiErrors.invalidURL.localizedDescription)
            return
        }

        do {
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                _ = try decoder.decode(Page.self, from: data)
                state = .loaded

            } catch let decodingError as DecodingError {
                state = .error(decodingError.localizedDescription)

            } catch {
                state = .error(error.localizedDescription)
            }

        } catch let urlError as URLError {
            state = .error(ApiErrors.network(urlError).localizedDescription)
        } catch {
            state = .error(error.localizedDescription)
        }

    }
}
