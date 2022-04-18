//
//  ViewController.swift
//  Weather_24
//
//  Created by cmStudent on 2022/01/06.
//

import Foundation
import CoreLocation

@MainActor
@available(iOS 15,*)
class MainViewModel: ObservableObject {
    /// ステータス管理用のenum
    enum RequestStatus {
        case unexecuted // 未実行
        case success    // 成功
        case failed     // 失敗
    }

    // JSONの受け取りオブジェクト
    var weathrtJSON:ResultOneCall!

    let weatherEndPoint:String = "https://api.openweathermap.org/data/2.5"
    let oneCall:String = "onecall"
    
    //DammyにOpenWeatherのOneCallのAPIキーをappIDに代入してください
    let appID:String = "Dammy"

    // この値に変更があったら更新する
    // 実行ステータス
    @Published var status: RequestStatus

    // エラーが起きうる初期化（雑に作っているので本当はもっときちんとすべき）
    init() throws {
        // 初期化
        weathrtJSON = nil
        status = .unexecuted
        // エラーは呼び出し元で処理してもらう
        try settings()
    }
    
    

    private func settings() throws {
        // URLが正しくないならばエラー
        guard let url = URL(string: weatherEndPoint + "/" + oneCall) else {
            print("URLが間違っている")
            throw NSError()
        }

        // コンポーネントが作られなければエラー
        guard var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("コンポーネントが作られていない")
            throw NSError()
        }
        // パラメータの設定
        let request = Request(lat: "35.698389128352", lon: "139.69813269136", appid: appID)
        let mirror = Mirror(reflecting: request)

        var queryItems: [URLQueryItem] = []

        // よいこはまねしない。リフレクション（Mirror）はあまり使わないように
        for child in mirror.children {
            if let label = child.label,
               let value = child.value as? String {
                queryItems.append(URLQueryItem(name: label , value: value))
            } else {
                continue
            }
        }

        component.queryItems = queryItems

        // コンポーネントからURLが作成できなければエラー
        guard let componentURL = component.url else {
            throw NSError()
        }
        print(componentURL)
        Task {
            // Modelに処理を投げる
            let result = await Fetcher.fetch(from: componentURL)
            switch result {
            case .failure(let error):
                print(error)
                status = .failed
            case .success(let data):
                do {
//                    print(url)
                    let result = try JSONDecoder().decode(ResultOneCall.self, from: data)
                    print("test2")
                    weathrtJSON = result
                    
                    print(weathrtJSON.hourly.first)
                    
                    self.status = .success
                } catch {
                    // 失敗したら失敗のステータスに変更
                    status = .failed
//                    print(error)
                    print(error.localizedDescription)
//                    print("do-catch")
                }
            }//switch
        }//Task
    }
}
