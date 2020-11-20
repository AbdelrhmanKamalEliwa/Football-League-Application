//
//  APIResult.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/12/20.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(Error?)
    case decodingFailure(Error?)
    case badRequest(Error?)
}
