//
//  UnorderedListComponentView.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 05/03/2026.
//

import SwiftUI

public struct UnorderedListComponentView: View {
    @State public private(set) var viewModel: UnorderdListComponentViewmodel

    public init(viewModel: UnorderdListComponentViewmodel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ForEach(viewModel.unorderedList.items, id: \.self) { item in
            HStack {
                Text("-")
                ForEach(item.content, id: \.self) { content in
                    ComponentView(viewModel: .init(content: content))
                }
            }

        }

    }
}

//#Preview {
//    TabViews()
//}
