//
//  TVGRouter.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation
import UIKit

// entryPoint type alias for TVGView Protocol and UIVIewController
typealias EntryPoint = TVGView & UIViewController

// -TVGRouter Base router protocol
protocol TVGRouter {
    var entry: EntryPoint? { get }
    var data: TVGEntity? { get }
    static func start(with data:TVGEntity?) -> TVGRouter
}
