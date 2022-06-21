//
//  TVGPersonsListPresenter.swift
//  TVGuide
//
//  Created by User on 20/06/22.
//

import Foundation
import Combine

protocol TVGPersonsListPresenterDelegate {
    func reloadTableView()
}

class TVGPersonsListPresenter: TVGPresenter {
    
    var view: TVGView?
    
    var interactor: TVGInteractor?
    
    var router: TVGRouter?
    
    var delegate: TVGPersonsListPresenterDelegate?
    
    private var persons = [TVGPersonEntity]()
    private var filteredPersons = [TVGPersonEntity]()
    private var isSearchingFilteredPersons: Bool = false
    private var isLoadingNewPage: Bool = false
    private var currentPage: Int = 1

    func didSelect(index: Int) {
        guard let router = router as? TVGPersonsListRouter else { return }
        let person = filteredPersons.count == 0 && !isSearchingFilteredPersons ? persons[index] : filteredPersons[index]
        router.routeToPersonsDetailViewController(with: person)
    }
    
    func getPersonsCount() -> Int {
        return  filteredPersons.count == 0 && !isSearchingFilteredPersons ? persons.count : filteredPersons.count
    }
    
    func getPersonTitle(at index: Int) -> String {
        return filteredPersons.count == 0 && !isSearchingFilteredPersons ? persons[index].name : filteredPersons[index].name
    }
    
    func filterPersons(with text: String) {
        isSearchingFilteredPersons = text.trimmingCharacters(in: .whitespaces).count != 0
        if isSearchingFilteredPersons {
            guard let interactor = interactor as? TVGPersonsListInteractor else { return }
            DispatchQueue.global(qos: .background).async {
                interactor.fetchSearchPersonsList(with: text)
            }
        }else {
            if filteredPersons.count > 0 {
                filteredPersons = [TVGPersonEntity]()
            }
            self.delegate?.reloadTableView()
        }
    }
    
    func viewDidLoad(){
        self.getShowsList()
    }
    
    private func getShowsList(with page: Int = 1) {
        guard let interactor = interactor as? TVGPersonsListInteractor else { return }
        DispatchQueue.global(qos: .background).async {
            interactor.fetchPersonsList(with: page)
        }
    }
    
    func getImageURL(at row: Int) -> URL? {
        let urlString = filteredPersons.count == 0 && !isSearchingFilteredPersons ? persons[row].image?.medium : filteredPersons[row].image?.medium
        let url = URL(string: urlString ?? "")
        return url
    }
    
    func showLoadingView() -> Bool{
        return persons.count == 0 && filteredPersons.count == 0 && !isSearchingFilteredPersons
    }
    
    func loadNewPage() {
        if !isLoadingNewPage {
            currentPage = currentPage + 1
            getShowsList(with: currentPage)
            isLoadingNewPage = true
        }
    }
}

extension TVGPersonsListPresenter: TVGPersonsListInteractorDelegate {
    
    func didFetchPersonsList(with shows: [TVGPersonEntity]) {
        if self.persons.count == 0 {
            self.persons = shows
        }else {
            self.persons.append(contentsOf: shows)
        }
        DispatchQueue.main.async {
            if self.isLoadingNewPage {
                self.isLoadingNewPage = false
            }
            self.delegate?.reloadTableView()
        }
    }
    
    func didFetchSearchedPersonsList(with searchedShows: [TVGPersonEntity]) {
        self.filteredPersons = searchedShows
        DispatchQueue.main.async {
            self.delegate?.reloadTableView()
        }
    }

    func didFailedFetch() {
        viewDidLoad()
    }
}
