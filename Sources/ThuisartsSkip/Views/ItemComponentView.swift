//
//  ItemComponentView.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//
import SwiftUI
import Foundation

public struct ItemComponentView: View {
    @State public var path: [String] = []
    @State public private(set) var viewModel: ItemComponentViewModel

    public init(viewModel: ItemComponentViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
            NavigationLink(
                destination: PageView(urlPath: .detail(viewModel.item.url))
            ) {
                content
            }
    }


    @ViewBuilder
    var content: some View {
        switch viewModel.item.style {

        case .largeImageTopTitleBottom:
            LargeImageTopTitleBottom(viewModel: viewModel)

        case .imageTopTitleBottom:
            ImageTopTitleBottom(viewModel: viewModel)

        case .imageLeftTitleRight:
            
            ImageLeftTitleRight(viewModel: viewModel)

        case .titleTopSummaryBottom:
            TitleTopSummaryBottom(viewModel: viewModel)

        case .titleLeft:
            TitleLeft(viewModel: viewModel)

        case .titleLeftUnderlined:
            TitleLeftUnderlined(viewModel: viewModel)

        case .titleLeftArrowRight:
            TitleLeftArrowRight(viewModel: viewModel)

        case .titleLeftAccessoryRight:
            TitleLeftAccessoryRight(viewModel: viewModel)

        case .iconLeftTitleLeftAccessoryRight:
            IconLeftTitleLeftAccessoryRight(viewModel: viewModel)

        case .other:
            Other(viewModel: viewModel)
        }
    }
}

//#Preview {
//    TabViews()
//}
