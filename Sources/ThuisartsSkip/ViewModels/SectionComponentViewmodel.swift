//
//  SectionComponentViewmodel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 03/03/2026.
//

import SwiftUI
import SkipFuse
// SKIP @bridgeMembers
@MainActor
@Observable
public class SectionComponentViewmodel {
    public private(set) var section: SectionComponent

    public init(section: SectionComponent) {
        self.section = section
    }

}
