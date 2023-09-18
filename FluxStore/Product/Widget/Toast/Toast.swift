//
//  Toast.swift
//  FluxStore
//
//  Created by Berker Saptas on 16.09.2023.
//

import Foundation

struct Toast: Equatable {
    var type: ToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}
