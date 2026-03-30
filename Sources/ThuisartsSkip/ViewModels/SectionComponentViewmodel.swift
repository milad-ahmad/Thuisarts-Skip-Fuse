//
//  SectionComponentViewmodel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 03/03/2026.
//

import SwiftUI

@MainActor 
@Observable
public final class SectionComponentViewmodel {
    public private(set) var section: SectionComponent

    public init(section: SectionComponent) {
        self.section = section
    }

}
