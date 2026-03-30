//
//  ComponentView.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//
import SwiftUI
import Foundation

public struct ComponentView: View {

    @State public private(set) var viewModel: ComponentViewModel

    public init(viewModel: ComponentViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        content
    }

    @ViewBuilder
    var content: some View {
            if let text = viewModel.text {
                TextComponentView(viewModel: .init(text: text))
            } else if let image = viewModel.image {
                ImageComponentView(viewModel: .init(image: image))
            } else if let itemList = viewModel.itemList {
                ItemListComponentView(viewModel: .init(itemList: itemList))
                    .padding(.horizontal)
            } else if let accordion = viewModel.accordion {
                AccordionComponentView(viewModel: .init(accordion: accordion))
            } else if let section = viewModel.section {
                SectionComponentView(viewModel: .init(section: section))
            } else if let unorderedList = viewModel.unorderedList {
                UnorderedListComponentView(viewModel: .init(unorderedList: unorderedList))
            }

    }
}

//#Preview{
//    TabViews()
//}
