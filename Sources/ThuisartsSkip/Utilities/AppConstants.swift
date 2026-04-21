//
//  AppConstants.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 23/02/2026.
//

import Foundation
import SkipFuse
// SKIP @bridgeMembers
public enum AppConstants {

    // SKIP @bridgeMembers
    public enum EndPoints {
        public static let test = "https://tst.bff.thuisarts.egeniq.com"
        public static let acceptance = "https://acc.bff.thuisarts.egeniq.com"
    }
    
    // SKIP @bridgeMembers
    public enum PageState: Sendable {
        case loading
        case loaded
        case error(String)
    }

}
