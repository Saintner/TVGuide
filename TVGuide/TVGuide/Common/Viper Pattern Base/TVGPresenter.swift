//
//  TVGPresenter.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation

protocol TVGPresenter {
    var view: TVGView? { get set }
    var interactor: TVGInteractor? { get set }
    var router: TVGRouter? { get set }
}
