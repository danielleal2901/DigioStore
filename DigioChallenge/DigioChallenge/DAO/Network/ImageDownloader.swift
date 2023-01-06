//
//  ImageDownloader.swift
//  DigioChallenge
//
//  Created by Daniel Leal on 05/01/23.
//

import Foundation
import UIKit

protocol ImageDownloader {
    func download(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

struct ImageDownloaderClient: ImageDownloader {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func download(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let networkError = NetworkError(data: data, response: response, error: error) {
                completion(.failure(networkError))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}

extension UIImageView {
    func getImageFrom(url: URL, placeholder: UIImage? = nil, completion: ((Result<Void, Error>) -> Void)? = nil) {
        let downloader = ImageDownloaderClient()
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()

        DispatchQueue.global().async {
            downloader.download(from: url) { [weak self] result in
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    switch result {
                    case let .success(data):
                        self?.image = UIImage(data: data)
                        completion?(.success(()))
                    case let .failure(error):
                        self?.image = placeholder
                        completion?(.failure(error))
                    }
                }
            }
        }
    }
}
