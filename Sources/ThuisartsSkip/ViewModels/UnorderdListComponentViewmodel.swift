//
//  UnorderdListComponentViewmodel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 05/03/2026.
//

import SwiftUI
import SkipFuse
// SKIP @bridgeMembers
@MainActor
@Observable
public class UnorderdListComponentViewmodel {
    public private(set) var unorderedList: UnorderedListComponent

    public init(unorderedList: UnorderedListComponent) {
        self.unorderedList = unorderedList
    }

}
