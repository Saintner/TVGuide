//
//  TVGShowsListHeaderTableView.swift
//  TVGuide
//
//  Created by User on 19/06/22.
//

import Foundation
import UIKit

protocol TVGShowsListHeaderViewTableViewDelegate {
    func didChangeTextfield(with text: String)
}

class TVGShowsListHeaderViewTableView: UIView {
    
    var delegate: TVGShowsListHeaderViewTableViewDelegate?
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = TVGConstants.textFieldSearchPlaceholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTextField()
    }
    
    private func setTextField() {
        backgroundColor = .white
        searchTextField.delegate = self
        addSubview(searchTextField)
        setTextFieldConstraints()
    }
    
    private func setTextFieldConstraints() {
        let top = NSLayoutConstraint(item: searchTextField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10)
        let leading = NSLayoutConstraint(item: searchTextField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        let trailing = NSLayoutConstraint(item: searchTextField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15)
        let height = NSLayoutConstraint(item: searchTextField, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 45)
        let constraints = [top,leading,height,trailing]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func eraseText(){
        searchTextField.text = ""
    }

}

extension TVGShowsListHeaderViewTableView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.didChangeTextfield(with: text)
    }
}
