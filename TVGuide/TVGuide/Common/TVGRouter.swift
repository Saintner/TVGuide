//
//  TVGRouter.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation
import UIKit

// entryPoint type alias for IBKView Protocol and UIVIewController
typealias EntryPoint = TVGView & UIViewController

// -IBKRouter Base router protocol
protocol IBKRouter {
    var entry: EntryPoint? { get }
    var data: TVGEntity? { get }
    static func start(with data:IBKEntity?) -> IBKRouter
}
