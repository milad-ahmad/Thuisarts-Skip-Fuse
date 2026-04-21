//
//  ImageComponentViewModel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//
import Foundation
import Observation
import SkipFuse
// SKIP @bridgeMembers
@Observable
public class ImageComponentViewModel {
    public private(set) var image: ImageComponent

    public init(image: ImageComponent) {
        self.image = image
    }
}
