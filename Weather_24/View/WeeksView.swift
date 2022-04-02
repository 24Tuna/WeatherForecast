//
//  Weeks.swift
//  Weather_24
//
//  Created by cmStudent on 2022/01/05.
//

import SwiftUI
@available(iOS 15,*)
struct Weeks: View {
    @ObservedObject var viewModel:MainViewModel
    @ObservedObject var timeTranslater:UnixTimeTranslater
    
    init(){
        do{
            viewModel = try MainViewModel()
            timeTranslater = try UnixTimeTranslater()
        }catch{
            fatalError("URLエラー")
        }
    }
    
    var body: some View {
        VStack {
            if let weather = viewModel.weathrtJSON{
                ScrollView{
                    ForEach(0..<weather.daily.count){ i in
                        HStack{
                            Spacer()
                        
                            Text(timeTranslater.DayTranslate(unixTime: weather.hourly[i].dt))
                            
                            Image(weather.daily[i].weather.first?.icon ?? "")
                                .resizable()
                                .frame(width:50,height:50)
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                            VStack{
                                Text(weather.daily[i].weather.first?.weatherDescription ?? "")
                                    .font(.title2)
                                Text("最高気温" + String(round(weather.daily[i].temp.max * 10) / 10) + "℃")
                                Text("最低気温" + String(round(weather.daily[i].temp.min * 10) / 10) + "℃")
                            }
                            Spacer()
                        }
                        
                    }
                }
                
            }else{
                Text("エラー")
            }
        }
    }
}
