//
//  TextComponentViewModel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//

import Foundation
import Observation
import SkipFuse

@MainActor 
@Observable
public final class TextComponentViewModel {
    public private(set) var text: TextComponent

    public init(text: TextComponent) {
        self.text = text
    }

}
