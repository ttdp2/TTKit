//
//  PopUpLabelViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/6/18.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class LabelViewController: BaseViewController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addLabelButton = UIBarButtonItem(title: "Pop Up", style: .done, target: self, action: #selector(addLabel))
        navigationItem.rightBarButtonItem = addLabelButton
    }
    
    @objc func addLabel() {
        let popUpVC = PopUpLabelViewController()
        popUpVC.modalPresentationStyle = .custom
        popUpVC.transitioningDelegate = self
        
        present(popUpVC, animated: true)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAlertPresentAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAlertDismissAnimationController()
    }
    
}

struct AimLabel {
    let label: String
    let color: String
}

protocol PopUpLabelViewDelegate {
    func popUpLabelViewDidCancel()
    func popUpLabelViewDidSelect(_ label: AimLabel)
}

class PopUpLabelViewController: BaseViewController, UITextViewDelegate {
    
    var delegate: PopUpLabelViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    func addKeyboardObserver() {
        // Input fields move up when keyboard shows
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - View
    
    let dimView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.2
        return view
    }()
    
    var containerViewCenterYConstraint: NSLayoutConstraint!
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F0F0F0")
        view.layer.cornerRadius = 13
        view.clipsToBounds = true
        return view
    }()
    
    let toLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "To: "
        label.textColor = .darkGray
        return label
    }()
    
    let fullName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Colors.border.cgColor
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = .darkGray
        view.contentInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        view.delegate = self
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        button.addTarget(self, action: #selector(touchUp), for: .touchDragOutside)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        button.addTarget(self, action: #selector(touchUp), for: .touchDragOutside)
        button.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        return button
    }()
    
    override func setupViews() {
        view.backgroundColor = .clear
        
        view.addSubview(dimView)
        view.addConstraints(format: "H:|[v0]|", views: dimView)
        view.addConstraints(format: "V:|[v0]|", views: dimView)
        
        view.addSubview(containerView)
        view.addConstraints(format: "H:[v0(290)]", views: containerView)
        view.addConstraints(format: "V:[v0(220)]", views: containerView)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerViewCenterYConstraint = containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        containerViewCenterYConstraint.isActive = true
        
        containerView.addSubview(toLabel)
        containerView.addSubview(fullName)
        containerView.addConstraints(format: "H:|-15-[v0][v1]", views: toLabel, fullName)
        containerView.addConstraints(format: "V:|[v0(40)]", views: toLabel)
        fullName.centerYAnchor.constraint(equalTo: toLabel.centerYAnchor).isActive = true
        
        containerView.addSubview(textView)
        containerView.addConstraints(format: "H:|-15-[v0]-15-|", views: textView)
        containerView.addConstraints(format: "V:|-40-[v0(120)]", views: textView)
        
        containerView.addSubview(cancelButton)
        containerView.addSubview(sendButton)
        containerView.addConstraints(format: "H:|[v0]", views: cancelButton)
        containerView.addConstraints(format: "H:[v0]|", views: sendButton)
        containerView.addConstraints(format: "V:[v0(45)]|", views: cancelButton)
        containerView.addConstraints(format: "V:[v0(45)]|", views: sendButton)
        cancelButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

        let xSeparator = UIView()
        xSeparator.backgroundColor = .lightGray
        
        containerView.addSubview(xSeparator)
        containerView.addConstraints(format: "H:|[v0]|", views: xSeparator)
        containerView.addConstraints(format: "V:[v0(0.5)]-45-|", views: xSeparator)
        
        let ySeparator = UIView()
        ySeparator.backgroundColor = .lightGray
        
        containerView.addSubview(ySeparator)
        containerView.addConstraints(format: "H:[v0(0.5)]", views: ySeparator)
        containerView.addConstraints(format: "V:[v0(45)]|", views: ySeparator)
        ySeparator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    // MARK: - UITextView Delegate
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            sendButton.isEnabled = false
            sendButton.setTitleColor(.lightGray, for: .normal)
        } else {
            sendButton.isEnabled = true
            sendButton.setTitleColor(.systemBlue, for: .normal)
        }
    }
    
    // MARK: - Action
    
    @objc func touchDown(_ sender: UIButton) {
        sender.backgroundColor = UIColor(hex: "DEDEDE")
    }
    
    @objc func touchUp(_ sender: UIButton) {
        resetBackground(sender)
    }
    
    @objc func handleCancel(_ sender: UIButton) {
        resetBackground(sender)
        dismiss(animated: true)
        
        delegate?.popUpLabelViewDidCancel()
    }
    
    @objc func handleSelect(_ sender: UIButton) {
        resetBackground(sender)
        dismiss(animated: true)
        
        delegate?.popUpLabelViewDidSelect(AimLabel(label: "", color: ""))
    }
    
    func resetBackground(_ button: UIButton) {
        button.backgroundColor = UIColor(hex: "#F0F0F0")
    }
    
    @objc func handleKeyboard(notification: Notification) {
        if let _ = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let isShowing = notification.name == UIResponder.keyboardWillShowNotification
            containerViewCenterYConstraint.constant = isShowing ? -80 : 0
        }
        
        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
        }
    }
    
}
