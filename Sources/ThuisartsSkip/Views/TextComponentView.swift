//
//  TextComponentView.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//
import Foundation
import SwiftUI

public struct TextComponentView: View {

    @State public private(set) var viewModel: TextComponentViewModel

    public init(viewModel: TextComponentViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        let text = convertHTMLLinks(viewModel.text.content)
        Text(.init(text))
    }
    
    private func convertHTMLLinks(_ html: String) -> String {
        return html.replacingOccurrences(
            of: "<a\\s+[^>]*href=\"([^\"]+)\"[^>]*>(.*?)</a>",
            with: "[$2]($1)",
            options: .regularExpression
        )
    }
}

//#Preview{
//    TabViews()
//}
