//
//  TVGShowsListPresenter.swift
//  TVGuide
//
//  Created by User on 18/06/22.
//

import Foundation
import Combine

protocol TVGShowsListPresenterDelegate {
    func reloadTableView()
}

class TVGShowsListPresenter: TVGPresenter {
    
    var view: TVGView?
    
    var interactor: TVGInteractor?
    
    var router: TVGRouter?
    
    var delegate: TVGShowsListPresenterDelegate?
    
    private var shows = [TVGShowEntity]()
    private var filteredShows = [TVGShowEntity]()
    private var isSearchingFilteredShows: Bool = false
    private var isLoadingNewPage: Bool = false
    private var currentPage: Int = 1

    func didSelect(index: Int) {
        guard let router = router as? TVGShowsListRouter else { return }
        let show = filteredShows.count == 0 && !isSearchingFilteredShows ? shows[index] : filteredShows[index]
        router.routeToDetailShowViewController(with: show)
    }
    
    func goToFavorites() {
        
    }
    
    func goToPersons() {
        guard let router = router as? TVGShowsListRouter else { return }
        router.routeToPersonsListViewController()
    }
    
    func getShowsCount() -> Int {
        return  filteredShows.count == 0 && !isSearchingFilteredShows ? shows.count : filteredShows.count
    }
    
    func getShowTitle(at index: Int) -> String {
        return filteredShows.count == 0 && !isSearchingFilteredShows ? shows[index].name : filteredShows[index].name
    }
    
    func filterShows(with text: String) {
        isSearchingFilteredShows = text.trimmingCharacters(in: .whitespaces).count != 0
        if isSearchingFilteredShows {
            guard let interactor = interactor as? TVGShowsListInteractor else { return }
            DispatchQueue.global(qos: .background).async {
                interactor.fetchSearchShowsList(with: text)
            }
        }else {
            if filteredShows.count > 0 {
                filteredShows = [TVGShowEntity]()
            }
            self.delegate?.reloadTableView()
        }
    }
    
    func viewDidLoad(){
        self.getShowsList()
    }
    
    private func getShowsList(with page: Int = 1) {
        guard let interactor = interactor as? TVGShowsListInteractor else { return }
        DispatchQueue.global(qos: .background).async {
            interactor.fetchShowsList(with: page)
        }
    }
    
    func getImageURL(at row: Int) -> URL? {
        let urlString = filteredShows.count == 0 && !isSearchingFilteredShows ? shows[row].image?.medium : filteredShows[row].image?.medium
        let url = URL(string: urlString ?? "")
        return url
    }
    
    func showLoadingView() -> Bool{
        return shows.count == 0 && filteredShows.count == 0 && !isSearchingFilteredShows
    }
    
    func loadNewPage() {
        if !isLoadingNewPage {
            currentPage = currentPage + 1
            getShowsList(with: currentPage)
            isLoadingNewPage = true
        }
    }
}

extension TVGShowsListPresenter: TVGShowsListInteractorDelegate {
    
    func didFetchShowsList(with shows: [TVGShowEntity]) {
        if self.shows.count == 0 {
            self.shows = shows
        }else {
            self.shows.append(contentsOf: shows)
        }
        DispatchQueue.main.async {
            if self.isLoadingNewPage {
                self.isLoadingNewPage = false
            }
            self.delegate?.reloadTableView()
        }
    }
    
    func didFetchSearchedShowsList(with searchedShows: [TVGShowEntity]) {
        self.filteredShows = searchedShows
        DispatchQueue.main.async {
            self.delegate?.reloadTableView()
        }
    }
    
    func didFailedFetch() {
        viewDidLoad()
    }
}
