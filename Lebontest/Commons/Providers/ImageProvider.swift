//
//  ImageProvider.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import UIKit

protocol ImageProviderType: AnyObject {
    func getImage(from url: String?, completion: ((UIImage?) -> Void)?)
}

class ImageProvider: ImageProviderType {

    private var cachedImages: [String: UIImage] = [:]
    private let queue = DispatchQueue(label: "lebontest.imageprovider", qos: DispatchQoS.userInteractive)

    func getImage(from url: String?, completion: ((UIImage?) -> Void)?) {
        guard let urlString = url, let url = URL(string: urlString) else {
            completion?(nil)
            return
        }

        queue.sync {
            if let cachedImage = cachedImages[urlString] {
                completion?(cachedImage)
                return
            }
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            let image = UIImage(data: data)
            self.queue.sync {
                self.cachedImages[urlString] = image
            }
            completion?(image)
        }
        task.resume()
    }
}
