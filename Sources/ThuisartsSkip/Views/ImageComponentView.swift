//
//  ImageComponentView.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//
import SwiftUI
import Foundation
import SkipFuse
//import Kingfisher

public struct ImageComponentView: View {

    @State public private(set) var viewModel: ImageComponentViewModel

    public init(viewModel: ImageComponentViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        let image = viewModel.image
        switch viewModel.image.style {
        case .header:
            HeaderImageComponent(image: image)
        case .default:
            DefaultImageComponent(image: image)
        }

    }
}

public struct DefaultImageComponent: View {

    private let image: ImageComponent

    public init(image: ImageComponent) {
        self.image = image
    }

    public var body: some View {
        imageContent
    }

    @ViewBuilder
    var imageContent: some View {
        if let imageUrl = image.url, !imageUrl.isEmpty {
            
            AsyncImage(url: URL(string: imageUrl)) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.leading, 8)
            } placeholder: {
                Image(systemName: "photo.badge.exclamationmark")
                    .font(.system(.largeTitle, weight: .light))
                    .foregroundStyle(.gray)
            }
        } else {
            Image(systemName: "photo.badge.exclamationmark")
                .font(.system(.largeTitle, weight: .light))
                .foregroundStyle(.gray)
        }
    }
}

public struct HeaderImageComponent: View {

    private let image: ImageComponent

    public init(image: ImageComponent) {
        self.image = image
    }

    public var body: some View {
            imageContent
    }

    @ViewBuilder
    var imageContent: some View {
        if let imageUrl = image.url, !imageUrl.isEmpty {
            AsyncImage(url: URL(string: imageUrl)) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.leading, 8)
            } placeholder: {

            }
        } else {
            Image(systemName: "photo.badge.exclamationmark")
                .font(.system(.title, weight: .light))
                .foregroundStyle(.gray)
        }
    }
}

//#Preview{
//    TabViews()
//}
