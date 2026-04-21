//
//  AccordionComponentViewModel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 03/03/2026.
//

import SwiftUI
import SkipFuse
// SKIP @bridgeMembers
@MainActor
@Observable
public class AccordionComponentViewModel {
    public var accordion: AccordionComponent

    public init(accordion: AccordionComponent) {
        self.accordion = accordion
    }

}
