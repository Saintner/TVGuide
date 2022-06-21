//
//  TVGPersonDetailPresenter.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation

protocol TVGPersonDetailPresenterDelegate {
    func reloadTableView()
}

class TVGPersonDetailPresenter: TVGPresenter {
    var view: TVGView?
    
    var interactor: TVGInteractor?
    
    var router: TVGRouter?
    
    var delegate: TVGPersonDetailPresenterDelegate?
    private var person: TVGPersonEntity
    private var shows: [TVGShowEntity] = []
    
    init(show: TVGPersonEntity) {
        self.person = show
    }
    
    func viewDidLoad(){
        DispatchQueue.global(qos: .background).async {
            let interactor = self.interactor as! TVGPersonDetailInteractor
            interactor.getPersonDetails(with: self.person.id)
        }
    }
    
    func getImageURL() -> URL? {
        let url = URL(string: person.image?.original ?? "")
        return url
    }
    
    func getPersonTitle() -> String {
        return person.name
    }
    
    func getShowsCount() -> Int {
        return shows.count
    }
    
    func getShowName(at row: Int) -> String? {
        return shows[row].name
    }
    
    func didSelectShow(at row: Int) {
        guard let router = router as? TVGPersonDetailRouter else { return }
        router.routeToShowDetailViewController(with: shows[row])
    }
    
}

extension TVGPersonDetailPresenter: TVGPersonDetailInteractorDelegate {
    func didFetchPersonDetails(with details: [TVGPersonShowsEntity]) {
        let shows = details.map { detail -> TVGShowEntity in
            return detail._embedded.show
        }
        self.shows = shows
        DispatchQueue.main.async {
            self.delegate?.reloadTableView()
        }
    }
    
    
}
