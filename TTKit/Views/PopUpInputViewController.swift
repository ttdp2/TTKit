//
//  PopUpInputViewController.swift
//  TTKit
//
//  Created by Tian Tong on 6/9/21.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit
import Foundation

class PopUpInputViewController: BaseViewController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertButton = UIBarButtonItem(title: "Alert", style: .done, target: self, action: #selector(alert))
        let popUpButton = UIBarButtonItem(title: "Pop Up", style: .done, target: self, action: #selector(popUp))
        navigationItem.rightBarButtonItems = [alertButton, popUpButton]
    }

    override func setupViews() {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 100)
        label.text = "WWDC"
        view.addSubview(label)
        view.addConstraints(format: "V:[v0]", views: label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func alert() {
        let alert = UIAlertController(title: "WWDC 2021", message: "Hello Swift", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Sure", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))
        present(alert, animated: true)
    }
    
    @objc func popUp() {
        let popUpVC = PopUpAlertViewController()
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

class CustomAlertPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let snapshot = toViewController.view.snapshotView(afterScreenUpdates: true)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        snapshot.frame = finalFrame
        snapshot.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        snapshot.alpha = 0.0
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshot)
        toViewController.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            snapshot.alpha = 1.0
            snapshot.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { _ in
            toViewController.view.isHidden = false
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}

class CustomAlertDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: true)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: fromViewController)
        
        snapshot.frame = finalFrame
        
        containerView.addSubview(snapshot)
        fromViewController.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            snapshot.alpha = 0.0
        }) { _ in
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}

class PopUpAlertViewController: BaseViewController, UITextViewDelegate {
    
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
    
    let toName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Tian Tong"
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
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
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
        containerView.addSubview(toName)
        containerView.addConstraints(format: "H:|-15-[v0][v1]", views: toLabel, toName)
        containerView.addConstraints(format: "V:|[v0(40)]", views: toLabel)
        toName.centerYAnchor.constraint(equalTo: toLabel.centerYAnchor).isActive = true
        
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
    }
    
    @objc func handleSend(_ sender: UIButton) {
        resetBackground(sender)
        dismiss(animated: true)
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
