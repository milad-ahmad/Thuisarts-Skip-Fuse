//
//  ItemListComponentView.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//
import Foundation
import SwiftUI

public struct ItemListComponentView: View {

    @State public private(set) var viewModel: ItemListComponentViewModel

    public init(viewModel: ItemListComponentViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        Group {
            ForEach(viewModel.itemList.items, id: \.self) { item in
                ItemComponentView(viewModel: .init(item: item))
            }
        }
//        .buttonStyle(.glass)
    }

}

//#Preview {
//    TabViews()
//}
