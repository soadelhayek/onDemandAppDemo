//
//  BaseCollectionViewCell.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation
import UIKit
import FSPagerView
import Nuke


class BaseCollectionViewCell: UICollectionViewCell {

    let feedbackGenerator: (notification: UINotificationFeedbackGenerator,
        impact: (light: UIImpactFeedbackGenerator,
        medium: UIImpactFeedbackGenerator,
        heavy: UIImpactFeedbackGenerator),
        selection: UISelectionFeedbackGenerator) = {
            return (notification: UINotificationFeedbackGenerator(),
                    impact: (light: UIImpactFeedbackGenerator(style: .light),
                             medium: UIImpactFeedbackGenerator(style: .medium),
                             heavy: UIImpactFeedbackGenerator(style: .heavy)),
                    selection: UISelectionFeedbackGenerator())
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
    }
}


class CustomPagerCell: FSPagerViewCell {
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = false
        }
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = false
        }
    }
}






import Foundation

extension String {
    public var url: URL? {
        do {
            return try self.asNiceURL()
        } catch {
            return nil
        }
    }
}

extension String {

    /// asURL, nice as there's alamofire extension with same name
    ///
    /// - Returns: URL
    /// - Throws: Error if it can't create url from string
    fileprivate func asNiceURL() throws -> URL {
        if self.range(of: "http") == nil {
            let newURl = "https:" + self
            return try newURl.asNiceURL()
        } else if self.range(of: "http") != nil {
            guard let url = URL(string: self.clearSpacesInURL) else { throw URLError(.badURL) }
            return  url
        } else {
            throw URLError(.badURL)
        }
    }
    
    fileprivate var clearSpacesInURL: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }

}

// MARK: - Helpers
extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
    
    func decodeUrl() -> String {
           return self.removingPercentEncoding ?? ""
       }
}




import UIKit
import SnapKit
class NicePageController: UIView {

    lazy var controller: UIPageControl = {
        let view = UIPageControl()
        view.currentPageIndicatorTintColor = UIColor.white.withAlphaComponent(0.8)
        view.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        add(controller)
        backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        layer.cornerRadius = 5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        controller.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
    }
}


extension UIView {
    func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    /// A helper function to add multiple subviews.
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
        }
    }

}
