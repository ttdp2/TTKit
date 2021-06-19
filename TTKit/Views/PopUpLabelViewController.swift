//
//  PopUpLabelViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/6/18.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class LabelViewController: BaseViewController, UIViewControllerTransitioningDelegate, PopUpLabelViewDelegate {
    
    var aimLabel: AimLabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addLabelButton = UIBarButtonItem(title: "Add label", style: .done, target: self, action: #selector(addLabel))
        navigationItem.rightBarButtonItem = addLabelButton
    }
    
    @objc func addLabel() {
        let popUpVC = PopUpLabelViewController()
        popUpVC.aimLabel = aimLabel
        popUpVC.modalPresentationStyle = .custom
        popUpVC.transitioningDelegate = self
        popUpVC.delegate = self
        
        present(popUpVC, animated: true)
    }
    
    // MARK: - PopUpLabelView Delegate
    
    func popUpLabelViewDidDelete(_ label: AimLabel) {
        aimLabel = nil
    }
    
    func popUpLabelViewDidSelect(_ label: AimLabel) {
        aimLabel = label
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
    let text: String
    let color: String
}

protocol PopUpLabelViewDelegate {
    func popUpLabelViewDidDelete(_ label: AimLabel)
    func popUpLabelViewDidSelect(_ label: AimLabel)
}

class PopUpLabelViewController: BaseViewController {

    var delegate: PopUpLabelViewDelegate?
    
    let greenHex = "#5EBD3E"
    let yellowHex = "#FFB900"
    let orangeHex = "#F78200"
    let redHex = "#E23838"
    let violetHex = "#973999"
    let blueHex = "#009CDF"
    
    var aimLabel: AimLabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardObserver()
        hideKeyboardWhenTappedAround()
        
        if let label = aimLabel {
            deleteButton.alpha = 1
            cancelButton.alpha = 0
            
            labelView.text = label.text
            labelView.textColor = UIColor(hex: label.color)
            labelView.backgroundColor = UIColor(hex: label.color, alpha: 0.1)
            labelView.alpha = 1
            
            textField.text = label.text
            
            doneButton.setTitleColor(.systemBlue, for: .normal)
            doneButton.isEnabled = true
            
            clearSelection()
            selectedColor = label.color
            
            switch label.color {
            case greenHex:
                setSelection(greenView)
            case yellowHex:
                setSelection(yellowView)
            case orangeHex:
                setSelection(orangeView)
            case redHex:
                setSelection(redView)
            case violetHex:
                setSelection(violetView)
            case blueHex:
                setSelection(blueView)
            default:
                fatalError("Not implemented yet")
            }
        } else {
            selectedColor = greenHex
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
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

    lazy var textField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return view
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        button.addTarget(self, action: #selector(touchUp), for: .touchDragOutside)
        button.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        button.alpha = 0
        return button
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
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        button.addTarget(self, action: #selector(touchUp), for: .touchDragOutside)
        button.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        return button
    }()
    
    lazy var labelView: UILabel = {
        let label = PaddingLabel(left: 8, right: 8)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(hex: greenHex)
        label.backgroundColor = UIColor(hex: greenHex, alpha: 0.1)
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.alpha = 0
        return label
    }()
    
    var selectedColor: String?
    
    lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: greenHex, alpha: 0.1)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectColor))
        view.addGestureRecognizer(tap)
        view.tag = 101
        return view
    }()

    lazy var yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: yellowHex, alpha: 0.1)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectColor))
        view.addGestureRecognizer(tap)
        view.tag = 102
        return view
    }()
    
    lazy var orangeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: orangeHex, alpha: 0.1)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectColor))
        view.addGestureRecognizer(tap)
        view.tag = 103
        return view
    }()
    lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: redHex, alpha: 0.1)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectColor))
        view.addGestureRecognizer(tap)
        view.tag = 104
        return view
    }()
    
    lazy var violetView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: violetHex, alpha: 0.1)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectColor))
        view.addGestureRecognizer(tap)
        view.tag = 105
        return view
    }()
    
    lazy var blueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: blueHex, alpha: 0.1)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectColor))
        view.addGestureRecognizer(tap)
        view.tag = 106
        return view
    }()
    
    override func setupViews() {
        view.backgroundColor = .clear
        
        view.addSubview(dimView)
        view.addConstraints(format: "H:|[v0]|", views: dimView)
        view.addConstraints(format: "V:|[v0]|", views: dimView)
        
        view.addSubview(containerView)
        view.addConstraints(format: "H:[v0(270)]", views: containerView)
        view.addConstraints(format: "V:[v0(226)]", views: containerView)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerViewCenterYConstraint = containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        containerViewCenterYConstraint.isActive = true
        
        containerView.addSubview(textField)
        containerView.addConstraints(format: "H:|-15-[v0]-15-|", views: textField)
        containerView.addConstraints(format: "V:|-15-[v0(34)]", views: textField)
        
        containerView.addSubview(labelView)
        containerView.addConstraints(format: "H:|-15-[v0]-(>=15)-|", views: labelView)
        containerView.addConstraints(format: "V:|-64-[v0(24)]", views: labelView)
        
        containerView.addSubview(greenView)
        containerView.addConstraints(format: "H:|-15-[v0(70)]", views: greenView)
        containerView.addConstraints(format: "V:|-103-[v0(24)]", views: greenView)
        
        containerView.addSubview(yellowView)
        containerView.addConstraints(format: "H:|-100-[v0(70)]", views: yellowView)
        containerView.addConstraints(format: "V:|-103-[v0(24)]", views: yellowView)

        containerView.addSubview(orangeView)
        containerView.addConstraints(format: "H:[v0(70)]-15-|", views: orangeView)
        containerView.addConstraints(format: "V:|-103-[v0(24)]", views: orangeView)
        
        containerView.addSubview(redView)
        containerView.addConstraints(format: "H:|-15-[v0(70)]", views: redView)
        containerView.addConstraints(format: "V:|-142-[v0(24)]", views: redView)
        
        containerView.addSubview(violetView)
        containerView.addConstraints(format: "H:|-100-[v0(70)]", views: violetView)
        containerView.addConstraints(format: "V:|-142-[v0(24)]", views: violetView)
        
        containerView.addSubview(blueView)
        containerView.addConstraints(format: "H:[v0(70)]-15-|", views: blueView)
        containerView.addConstraints(format: "V:|-142-[v0(24)]", views: blueView)
        
        containerView.addSubview(deleteButton)
        containerView.addSubview(cancelButton)
        containerView.addSubview(doneButton)
        containerView.addConstraints(format: "H:|[v0]", views: deleteButton)
        containerView.addConstraints(format: "H:|[v0]", views: cancelButton)
        containerView.addConstraints(format: "H:[v0]|", views: doneButton)
        containerView.addConstraints(format: "V:[v0(45)]|", views: deleteButton)
        containerView.addConstraints(format: "V:[v0(45)]|", views: cancelButton)
        containerView.addConstraints(format: "V:[v0(45)]|", views: doneButton)
        deleteButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

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

    // MARK: - Action
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        if text.isEmpty {
            labelView.alpha = 0
            doneButton.isEnabled = false
            doneButton.setTitleColor(.lightGray, for: .normal)
        } else {
            labelView.alpha = 1
            doneButton.isEnabled = true
            doneButton.setTitleColor(.systemBlue, for: .normal)
        }
        
        labelView.text = text
    }
    
    @objc func selectColor(_ sender: UITapGestureRecognizer) {
        clearSelection()
        
        guard let view = sender.view else { return }
        
        setSelection(view)
        
        switch view.tag {
        case 101:
            selectedColor = greenHex
            labelView.textColor = UIColor(hex: greenHex)
            labelView.backgroundColor = UIColor(hex: greenHex, alpha: 0.1)
        case 102:
            selectedColor = yellowHex
            labelView.textColor = UIColor(hex: yellowHex)
            labelView.backgroundColor = UIColor(hex: yellowHex, alpha: 0.1)
        case 103:
            selectedColor = orangeHex
            labelView.textColor = UIColor(hex: orangeHex)
            labelView.backgroundColor = UIColor(hex: orangeHex, alpha: 0.1)
        case 104:
            selectedColor = redHex
            labelView.textColor = UIColor(hex: redHex)
            labelView.backgroundColor = UIColor(hex: redHex, alpha: 0.1)
        case 105:
            selectedColor = violetHex
            labelView.textColor = UIColor(hex: violetHex)
            labelView.backgroundColor = UIColor(hex: violetHex, alpha: 0.1)
        case 106:
            selectedColor = blueHex
            labelView.textColor = UIColor(hex: blueHex)
            labelView.backgroundColor = UIColor(hex: blueHex, alpha: 0.1)
        default:
            fatalError("Not implemented yet")
        }
    }
    
    @objc func touchDown(_ sender: UIButton) {
        sender.backgroundColor = UIColor(hex: "DEDEDE")
    }
    
    @objc func touchUp(_ sender: UIButton) {
        resetBackground(sender)
    }
    
    @objc func handleDelete(_ sender: UIButton) {
        resetBackground(sender)
        dismiss(animated: true)
        
        guard let label = aimLabel else { return }
        delegate?.popUpLabelViewDidDelete(label)
    }
    
    @objc func handleCancel(_ sender: UIButton) {
        resetBackground(sender)
        dismiss(animated: true)
    }
    
    @objc func handleSelect(_ sender: UIButton) {
        resetBackground(sender)
        dismiss(animated: true)
        
        guard let text = textField.text?.trimmingCharacters(in: .whitespaces), let color = selectedColor else { return }
        
        let label = AimLabel(text: text, color: color)
        
        delegate?.popUpLabelViewDidSelect(label)
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
    
    // MARK: - Method
    
    func clearSelection() {
        [greenView, yellowView, orangeView, redView, violetView, blueView].forEach { view in
            view.layer.borderWidth = 0
            view.layer.borderColor = nil
        }
    }
    
    func setSelection(_ view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
    }

    func resetBackground(_ button: UIButton) {
        button.backgroundColor = UIColor(hex: "#F0F0F0")
    }
    
}

class PaddingLabel: UILabel {
    
    let topInset: CGFloat
    let leftInset: CGFloat
    let bottomInset: CGFloat
    let rightInset: CGFloat
    
    convenience init(left: CGFloat, right: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: right)
    }
    
    init(top: CGFloat = 0.0, left: CGFloat = 0.0, bottom: CGFloat = 0.0, right: CGFloat = 0.0) {
        topInset = top
        leftInset = left
        bottomInset = bottom
        rightInset = right
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
    
}
