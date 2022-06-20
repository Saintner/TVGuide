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
    private var filteredPosts = [TVGShowEntity]()
    private var isSearchingFilteredPosts: Bool = false
    private var isLoadingNewPage: Bool = false
    private var currentPage: Int = 1

    func didSelect(index: Int) {
        guard let router = router as? TVGShowsListRouter else { return }
        let post = filteredPosts.count == 0 && !isSearchingFilteredPosts ? shows[index] : filteredPosts[index]
        router.routeToDetailPostViewController(with: post)
    }
    
    func getPostsCount() -> Int {
        return  filteredPosts.count == 0 && !isSearchingFilteredPosts ? shows.count : filteredPosts.count
//        return shows.count
    }
    
    func getPostTitle(at index: Int) -> String {
//        return shows[index].name
        return filteredPosts.count == 0 && !isSearchingFilteredPosts ? shows[index].name : filteredPosts[index].name
    }
    
    func filterPosts(with text: String) {
        isSearchingFilteredPosts = text.trimmingCharacters(in: .whitespaces).count != 0
        if isSearchingFilteredPosts {
            guard let interactor = interactor as? TVGShowsListInteractor else { return }
            DispatchQueue.global(qos: .background).async {
                interactor.fetchSearchShowsList(with: text)
            }
        }else {
            if filteredPosts.count > 0 {
                filteredPosts = [TVGShowEntity]()
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
        let urlString = filteredPosts.count == 0 && !isSearchingFilteredPosts ? shows[row].image?.medium : filteredPosts[row].image?.medium
        let url = URL(string: urlString ?? "")
        return url
    }
    
    func showLoadingView() -> Bool{
        return shows.count == 0 && filteredPosts.count == 0 && !isSearchingFilteredPosts
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
        self.filteredPosts = searchedShows
        DispatchQueue.main.async {
            self.delegate?.reloadTableView()
        }
    }
    
    func didFailedFetch() {
        viewDidLoad()
    }
}
