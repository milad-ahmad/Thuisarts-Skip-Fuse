//
//  ItemListComponentViewModel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//

import Foundation
import Observation
import SkipFuse
// SKIP @bridgeMembers
@MainActor 
@Observable
public class ItemListComponentViewModel {

    public private(set) var itemList: ItemListComponent

    public init(itemList: ItemListComponent) {
        self.itemList = itemList
    }
}
