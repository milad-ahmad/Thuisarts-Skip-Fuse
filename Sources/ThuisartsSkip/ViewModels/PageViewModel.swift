//
//  PageViewModel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//

import Foundation
import SwiftUI

@MainActor 
@Observable
public final class PageViewModel {

    public private(set) var state: AppConstants.PageState = .loading

    public private(set) var page: Page?

    public init() {}

    func getData(for path: UrlPath) async {

        let finalUrlString = AppConstants.EndPoints.test + path.rawValue

        guard let url = URL(string: finalUrlString) else {
            state = .error(ApiErrors.invalidURL.localizedDescription)
            return
        }

        do {
        let (data, response) = try await URLSession.shared.data(from: url)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                state = .error(ApiErrors.httpStatus.localizedDescription)
                return
            }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let page = try decoder.decode(Page.self, from: data)
                self.page = page
                state = .loaded

            } catch let decodingError as DecodingError {
                state = .error(decodingError.localizedDescription)
            }

        } catch let urlError as URLError {
            state = .error(ApiErrors.network(urlError).localizedDescription)
        } catch {
            state = .error(error.localizedDescription)
        }

    }

}

public enum UrlPath: Equatable {

    case news
    case page
    case detail(String)

    var rawValue: String {
        switch self {
        case .news:
            return "/news"
        case .page:
            return "/page"
        case .detail(let url):
                if let url = URL(string: url) {
                    return "/pages" + url.path
                }
            return ApiErrors.invalidURL.localizedDescription
        }
    }
}

enum ApiErrors: Error {
    case invalidURL
    case invalidJson
    case decodeError(DecodingError)
    case httpStatus
    case network(URLError)
}
