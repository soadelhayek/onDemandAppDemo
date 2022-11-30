//
//  temp.swift
//  FlowadDemoApp
//
//  Created by soad hayek on 30.11.2022.
//

import Foundation
import UIKit
import FSPagerView
import Nuke


extension UIImageView {
    
    @discardableResult
    func setImage(with url: URL, _ placeHolder: UIImage?, mode: ImageProcessors.Resize.ContentMode = .aspectFill) -> ImageTask? {
        startAnimating()

        var resizedImageProcessors: [ImageProcessing] {
          return [  ImageProcessors.Resize(size: self.frame.size, contentMode: mode)]
        }
        
      let options = ImageLoadingOptions(
            placeholder: placeHolder,
            transition: .fadeIn(duration: 0.2)
          )

        return Nuke.loadImage(with: url, options: options, into: self, progress: nil) { [weak self] response in
            guard let self = self else {
              return
            }

            switch response {
            case .failure:
                self.image = placeHolder
            case let .success(imageResponse):
                self.image = imageResponse.image
            }
        }
        
    }

    @discardableResult
    func setImageWith(_ url: String?, placeHolder: UIImage? = nil, mode: ImageProcessors.Resize.ContentMode = .aspectFit) -> ImageTask? {
        image = nil
        Nuke.cancelRequest(for: self)
        do {
            guard let link = url?.url else {
                self.image = placeHolder
                throw URLError(.badURL)
            }
            return setImage(with: link, placeHolder, mode: mode)
        } catch {
            return nil
        }
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview == nil else {
            return
        }
        image = nil
        Nuke.cancelRequest(for: self)
    }
}

struct ImagesLoader {
    typealias ImageResult = ((_ image: UIImage?) -> Void)?
    static func loadImage(imageURL url: URL, completion: ImageResult) {
        ImagePipeline.shared.loadImage(
            with: url, completion: { response in
                switch response {
                case .failure:
                    completion?(nil)
                case let .success(imageResponse):
                    completion?(imageResponse.image)
                }
            })
    }
}
