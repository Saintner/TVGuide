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

    func didSelect(index: Int) {
        guard let router = router as? TVGShowsListRouter else { return }
        let post = shows[index]
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
        let newPosts = shows.filter({ $0.name.contains(text)})
        filteredPosts = newPosts
        self.delegate?.reloadTableView()
    }
    
    func viewDidLoad(){
        self.getShowsList()
    }
    
    private func getShowsList() {
        guard let interactor = interactor as? TVGShowsListInteractor else { return }
        DispatchQueue.global(qos: .background).async {
            interactor.fetchShowsList()
        }
    }
    
    func getImageURL(at row: Int) -> URL? {
        let urlString = shows[row].image.medium
        let url = URL(string: urlString)
        return url
    }
    
    func showLoadingView() -> Bool{
        return shows.count == 0 && filteredPosts.count == 0 && !isSearchingFilteredPosts
    }
}

extension TVGShowsListPresenter: TVGShowsListInteractorDelegate {
    
    func didFetchPostList(with shows: [TVGShowEntity]) {
        self.shows = shows
        DispatchQueue.main.async {
            self.delegate?.reloadTableView()
        }
    }
}
