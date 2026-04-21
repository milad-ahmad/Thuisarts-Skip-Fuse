//
//  PageView.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 23/02/2026.
//

//import Kingfisher
import SwiftUI

public struct PageView: View {
    let urlPath: UrlPath?

    @State internal var viewModel = PageViewModel()

    public init(urlPath: UrlPath = .news) {
        self.urlPath = urlPath
    }

    public var body: some View {
        NavigationStack {

            ScrollView(showsIndicators: false) {

                VStack(spacing: 24) {

                    if let content = viewModel.page?.content {
                        ForEach(content, id: \.self) { content in
                            ComponentView(viewModel: .init(content: content))
                        }

                    }

                }

            }
        }
        .task {
                if let urlPath {
                    await viewModel.getData(for: urlPath)
                }
        }
    }
}



struct SearchView: View {
    var body: some View {
        Text("search")
    }
}

struct BookmarkView: View {
    var body: some View {
        Text("Bookmark")
    }
}

struct AccountView: View {
    var body: some View {
        Text("Account")
    }
}
