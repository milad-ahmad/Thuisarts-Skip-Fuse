//
//  ItemComponentViewModel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//

import Foundation
import Observation
import SkipFuse

@MainActor 
@Observable
public class ItemComponentViewModel {

    public private(set) var item: ItemComponent

    public init(item: ItemComponent) {
        self.item = item
    }
}
