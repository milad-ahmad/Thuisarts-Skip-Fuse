//
//  UnorderdListComponentViewmodel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 05/03/2026.
//

import SwiftUI

@MainActor 
@Observable
public final class UnorderdListComponentViewmodel {
    public private(set) var unorderedList: UnorderedListComponent

    public init(unorderedList: UnorderedListComponent) {
        self.unorderedList = unorderedList
    }

}
