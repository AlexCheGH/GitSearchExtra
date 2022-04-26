//
//  TextFieldView.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/25/22.
//

import UIKit

protocol TextFieldSearchViewDelegate {
    func returnQuery(text: String)
}

class TextFieldSearchView: UIView {
    
    var delegate: TextFieldSearchViewDelegate?
    var view = UIView()
    
    func setupView() {
        
        let sidePadding: CGFloat = 16
        let elementsPadding: CGFloat = 14
        let defaultPadding: CGFloat = 10
        
        let label = createLabel()
        let textField = createTextField()
        
        textField.delegate = self
        
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        view.addSubview(label)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: defaultPadding),
        ])
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: elementsPadding),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sidePadding),
            textField.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        let text = Localization.Label.repository
        label.text = text
        label.font = .systemFont(ofSize: 34, weight: .bold)
        
        return label
    }
    
    private func createTextField() -> UITextField {
        let prompt = Localization.TextFieldPrompt.prompt
        
        //TextField setup
        let textField = UITextField()
        textField.placeholder = prompt
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.layer.cornerRadius = 10
        let color = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        textField.backgroundColor = color
        
        //Adding magnifying glass icon to textField
        let largeFont = UIFont.systemFont(ofSize: 18)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: configuration)
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        iconView.tintColor = .gray
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 41, height: 30))
        iconContainerView.addSubview(iconView)
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
        
        return textField
    }
}

extension TextFieldSearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        
        if !text.isEmpty {
            delegate?.returnQuery(text: text)
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    
}
