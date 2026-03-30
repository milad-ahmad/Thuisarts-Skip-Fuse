//
//  SectionComponentView.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 02/03/2026.
//

import SwiftUI

public struct SectionComponentView: View {
    @State public private(set) var viewModel: SectionComponentViewmodel

    public init(viewModel: SectionComponentViewmodel) {
        self.viewModel = viewModel
    }

    public var body: some View {

        VStack(alignment: .leading, spacing: 16) {
            if let contentItems = viewModel.section.content {
                ForEach(contentItems, id: \.self) { item in
                    ComponentView(viewModel: .init(content: item))
                }
            }

        }

    }

}

//#Preview {
//    TabViews()
//}
