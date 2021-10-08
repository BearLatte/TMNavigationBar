//
//  TMNavigationBar.swift
//  TMNavigationBar
//
//  Created by Tim on 2021/9/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

// MARK: - 公开接口中的属性
open class TMNavigationBar: UIView {
    /// 左边按钮点击回调
    public var leftButtonItemDidTapAction: (() -> Void)?
    
    /// 右边按钮点击回调
    public var rightButtonItemDidTapAction: (() -> Void)?
    
    /// 标题
    public var title: String? {
        didSet {
            titleLabel.isHidden = false
            titleLabel.text = title
        }
    }
    
    /// 标题颜色, 默认为纯黑色
    public var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    /// 标题字体，默认为粗体15号字
    public var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 15) {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    /// 导航栏背景颜色，默认为纯白色
    public var barBackgroundColor: UIColor = .white {
        didSet {
            backgroundImageView.isHidden = true
            backgroundView.isHidden = false
            backgroundView.backgroundColor = barBackgroundColor
        }
    }
    
    /// 导航栏背景图片，设置了之后默认会隐藏默认背景颜色
    public var barBackgroundImage: UIImage? {
        willSet {
            backgroundView.isHidden = true
            backgroundImageView.isHidden = false
            backgroundImageView.image = newValue
        }
    }
    
    /// 背景透明度，默认为不透明
    public var backgroundAlpha: CGFloat = 1.0 {
        willSet {
            backgroundView.alpha = newValue
            backgroundImageView.alpha = newValue
            titleLabel.alpha = newValue
            bottomLine.alpha = newValue
        }
    }
    
    /// 设置 `tintColor` 控制文字颜色
    public  override var tintColor: UIColor? {
        willSet {
            if newValue != nil {
                leftButton.setTitleColor(newValue, for: .normal)
                rightButton.setTitleColor(newValue, for: .normal)
                titleLabel.textColor = newValue
            }
        }
    }
    
    
    /// 设置 `barTintColor` 控制背景颜色
    /// 一般不需要设置，需要用到时可以单独设置
    public  var barTintColor: UIColor? {
        willSet {
            backgroundColor = newValue
        }
    }
    
    /// 是否隐藏下划线, 默认显示
    public var isHiddBottomLine: Bool = false {
        didSet {
            bottomLine.isHidden = isHiddBottomLine
        }
    }
    
    /// 下划线颜色，默认为亮灰色
    public var bottomLineColor: UIColor = .lightGray {
        didSet {
            bottomLine.backgroundColor = bottomLineColor
        }
    }
    
    
    
    
    /// 初始化
    public class func navigationBar() -> TMNavigationBar {
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: width, height: Constant.navigationBarHeight)
        return TMNavigationBar(frame: frame)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    
    /// 标题标签
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = titleColor
        label.font = titleFont
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    /// 背景图片视图
    private lazy var backgroundImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isHidden = true
        return imgView
    }()
    
    /// 背景视图
    private lazy var backgroundView = UIView()
    
    /// 左按钮
    private lazy var leftButton = { () -> UIButton in
        let left = UIButton(type: .custom)
        left.imageView?.contentMode = .center
        left.isHidden = true
        left.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
        return left
    }()
    
    private lazy var rightButton = { () -> UIButton in
        let right = UIButton(type: .custom)
        right.imageView?.contentMode = .center
        right.isHidden = true
        right.addTarget(self, action: #selector(rightBtnClicked), for: .touchUpInside)
        return right
    }()
    
    /// navigationBar 下面的分割线，默认为亮灰色
    private lazy var bottomLine = { () -> UIView in
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()
}

// MARK: - UI相关设置
extension TMNavigationBar {
    private func setupSubviews() {
        addSubview(backgroundView)
        addSubview(backgroundImageView)
        addSubview(leftButton)
        addSubview(titleLabel)
        addSubview(rightButton)
        addSubview(bottomLine)
        updateFrame()
        backgroundColor = .clear
        backgroundView.backgroundColor = barBackgroundColor
    }
    
    private func updateFrame() {
        let topMargin: CGFloat = Constant.isBangs ? 44 : 20
        let margin: CGFloat = 0
        let buttonWidth: CGFloat = 44.0
        let buttonHeight = buttonWidth
        let rightBtnX = UIScreen.main.bounds.width - buttonWidth - margin
        let titleWidth: CGFloat = 180
        let titleHeight: CGFloat = 44
        let titelX = (UIScreen.main.bounds.width - titleWidth) * 0.5
        
        backgroundView.frame = bounds
        backgroundImageView.frame = bounds
        leftButton.frame = CGRect(x: margin, y: topMargin, width: buttonWidth, height: buttonHeight)
        titleLabel.frame = CGRect(x: titelX, y: topMargin, width: titleWidth, height: titleHeight)
        rightButton.frame = CGRect(x: rightBtnX, y: topMargin, width: buttonWidth, height: buttonHeight)
        bottomLine.frame = CGRect(x: 0, y: bounds.height - 0.5, width: UIScreen.main.bounds.width, height: 0.5)
    }
}

// MARK: - 导航栏按钮事件
extension TMNavigationBar {
    @objc func backBtnClicked() {
        guard let leftBtnClickedAction = leftButtonItemDidTapAction else {
            let currentVC = UIViewController.tm_currentViewController()
            currentVC.tm_toPreviousViewController(animated: true)
            return
        }
        
        leftBtnClickedAction()
    }
    
    @objc func rightBtnClicked() {
        rightButtonItemDidTapAction?()
    }
}

// MARK: - 按钮的常规操作
public extension TMNavigationBar {
    
    /// 自定义左边按钮的图片，注意按钮图片与文字是冲突的
    /// - Parameters:
    ///   - normalImage: 缺省状态的图片
    ///   - hightlightedImage: 高亮状态的图片
    func setLeftButtonItem(normalImage: UIImage?, hightlightedImage: UIImage?) {
        setLeftButtonItem(title: nil, titleColor: nil, normalImage: normalImage, highlightedImage: hightlightedImage)
    }
    
    /// 自定义左边按钮的文字，注意按钮图片与文字是冲突的
    /// - Parameters:
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    func setLeftButtonItem(title: String?, titleColor: UIColor?) {
        setLeftButtonItem(title: title, titleColor: titleColor, normalImage: nil, highlightedImage: nil)
    }
    
    /// 自定义右边按钮的图片，注意按钮图片与文字是冲突的
    /// - Parameters:
    ///   - normalImage: 缺省状态的图片
    ///   - hightlightedImage: 高亮状态的图片
    func setRightButtonItem(normalImage: UIImage?, hightlightedImage: UIImage?) {
        setRightButtonItem(title: nil, titleColor: nil, normalImage: normalImage, highlightedImage: hightlightedImage)
    }
    
    /// 自定义右边按钮的文字，注意按钮图片与文字是冲突的
    /// - Parameters:
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    func setRightButtonItem(title: String?, titleColor: UIColor?) {
        setRightButtonItem(title: title, titleColor: titleColor, normalImage: nil, highlightedImage: nil)
    }
    
    
    private func setLeftButtonItem(title: String?, titleColor: UIColor?, normalImage: UIImage?, highlightedImage: UIImage?) {
        leftButton.isHidden = false
        leftButton.setTitle(title, for: .normal)
        leftButton.setTitleColor(titleColor, for: .normal)
        leftButton.setImage(normalImage, for: .normal)
        leftButton.setImage(highlightedImage, for: .highlighted)
    }
    
    private func setRightButtonItem(title: String?, titleColor: UIColor?, normalImage: UIImage?, highlightedImage: UIImage?) {
        rightButton.isHidden = false
        rightButton.setTitle(title, for: .normal)
        rightButton.setTitleColor(titleColor, for: .normal)
        rightButton.setImage(normalImage, for: .normal)
        rightButton.setImage(highlightedImage, for: .highlighted)
    }
}

