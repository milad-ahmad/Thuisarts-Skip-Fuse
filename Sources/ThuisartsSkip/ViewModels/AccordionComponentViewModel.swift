//
//  AccordionComponentViewModel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 03/03/2026.
//

import SwiftUI

@MainActor 
@Observable
public final class AccordionComponentViewModel {
    public private(set) var accordion: AccordionComponent

    public init(accordion: AccordionComponent) {
        self.accordion = accordion
    }

}
