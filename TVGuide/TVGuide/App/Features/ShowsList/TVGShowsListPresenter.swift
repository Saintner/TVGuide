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
//        return  filteredPosts.count == 0 && !isSearchingFilteredPosts ? posts.count : filteredPosts.count
        return shows.count
    }
    
    func getPostTitle(at index: Int) -> String {
        return shows[index].name
//        return filteredPosts.count == 0 && !isSearchingFilteredPosts ? posts[index].title : filteredPosts[index].title
    }
    
    func filterPosts(with text: String) {
//        isSearchingFilteredPosts = text.trimmingCharacters(in: .whitespaces).count != 0
//        let newPosts = posts.filter({ $0.title.contains(text)})
//        filteredPosts = newPosts
//        self.delegate?.reloadTableView()
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
    
    func getImageData(at row: Int) -> Data {
        let urlString = shows[row].image.medium
        let url = URL(string: urlString)
        let data = try! Data(contentsOf: url!)
        return data
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
