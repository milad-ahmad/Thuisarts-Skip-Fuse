//
//  AccordionComponentView.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 02/03/2026.
//

import SwiftUI

public struct AccordionComponentView: View {
    @State public private(set) var viewModel: AccordionComponentViewModel

    public init(viewModel: AccordionComponentViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.accordion.content, id: \.self) { section in
                SectionComponentView(viewModel: .init(section: section))
            }
        }
    }
}

//#Preview {
//    TabViews()
//}
