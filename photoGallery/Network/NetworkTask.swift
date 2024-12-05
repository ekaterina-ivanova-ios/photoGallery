//
//  NetworkTask.swift
//  photoGallery
//
//  Created by Екатерина Иванова on 05.12.2024.
//

import Foundation

protocol NetworkTask {
    func cancel()
}

struct DefaultNetworkTask: NetworkTask {
    let dataTask: URLSessionDataTask

    func cancel() {
        dataTask.cancel()
    }
}
