//
//  titleLeftUnderlined.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 26/02/2026.
//

import SwiftUI

struct TitleLeftUnderlined: View {
    @State public private(set) var viewModel: ItemComponentViewModel

    var body: some View {
        HStack {
            // If there is no image, a default systemImage will be shown in the ImageComponentView
            if let image = viewModel.item.image {
                DefaultImageComponent(image: image)
                    .frame(width: 150)
                Spacer()
            }
            Text(viewModel.item.title)
        }
    }
}
