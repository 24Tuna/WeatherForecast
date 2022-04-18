//
//  Fetcher.swift
//  Weather_24
//
//  Created by cmStudent on 2022/01/06.
//

import Foundation

@available(iOS 15,*)
class Fetcher{

    private init() {}

    //エラーの種類
    enum FetchError: Error {
        case networkError
        case statusError
    }

    static func fetch(from url: URL, session: URLSession? = nil) async -> Result<Data, Error> {

        // リクエストを作成してfetch(from:session:handler:)に投げる
        let request = URLRequest(url: url)
        return await self.fetch(from: request, session: session)

    }

    static func fetch(from request: URLRequest, session: URLSession? = nil) async -> Result<Data, Error> {
        let session = (session == nil) ? URLSession(configuration: .default) : session!

        do {
            // awaitを使う 非同期（別スレッド）で実行中
            let (data, response) = try await session.data(for: request)

            guard let response = response as? HTTPURLResponse else {
                return .failure(FetchError.networkError)
            }

            if !(200...299).contains(response.statusCode) {
                print("ステータスコードが正常ではありません： \(response.statusCode)")
                return .failure(FetchError.statusError)
            }

            return .success(data)
        } catch(let error) {
            return .failure(error)
        }
    }

}


