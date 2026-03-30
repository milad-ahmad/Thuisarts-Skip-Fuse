//
//  AppConstants.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 23/02/2026.
//

import Foundation

public enum AppConstants {

    public enum EndPoints {
        public static let test = "https://tst.bff.thuisarts.egeniq.com"
        public static let acceptance = "https://acc.bff.thuisarts.egeniq.com"
    }

    public enum PageState {
        case loading
        case loaded
        case error(String)
    }

}
