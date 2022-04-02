//
//  ToDayView.swift
//  Weather_24
//
//  Created by cmStudent on 2021/12/26.
//

import SwiftUI
@available(iOS 15,*)
struct ToDayView: View {
    let dateFormatter = DateFormatter()

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
                ZStack{
                    Image(weather.hourly.first!.weather.first!.main)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    //黒の不透明フィルタ
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.1))
                    VStack{
                            VStack{
                            
                                Spacer()
                                    
                                ToDayTextView(textStr: timeTranslater.DayTranslate(unixTime: weather.hourly.first!.dt))
                                    
                                ToDayTextView(textStr: timeTranslater.TimeTranslate(unixTime: weather.minutely.first!.dt))
                                    
                                ToDayTextView(textStr: weather.timezone)
                                    
                                Spacer()
                                    
                                Image(weather.hourly.first?.weather.first?.icon ?? "")
                                    .resizable()
                                    .frame(width:80,height:80)
                                    .aspectRatio(contentMode: .fit)
                                    
                                Spacer()
                                    
                                Group{
                                    ToDayTextView(textStr:  weather.hourly.first?.weather.first?.weatherDescription ?? "エラー")
                                        
                                    ToDayTextView(textStr: "気温" + TempRound(temp: weather.hourly.first?.temp ?? 0) + "℃")
                                        
                                    ToDayTextView(textStr: "湿度" + String(weather.hourly.first?.humidity ?? 0) + "%" )
                                }
                                    
                                Spacer()
                                    
                                ScrollView(.horizontal){
                                    HStack{
                                        ForEach(0..<weather.hourly.count){i in
                                            VStack{
                                                Text(timeTranslater.TimeTranslate(unixTime: weather.hourly[i].dt))
                                                    .foregroundColor(Color.white)
                                                Image(weather.hourly[i].weather.first?.icon ?? "")
                                                    .resizable()
                                                    .frame(width:50,height:50)
                                                    .aspectRatio(contentMode: .fit)
                                                Text(TempRound(temp: weather.hourly[i].temp) + "℃")
                                                    .foregroundColor(Color.white)
                                                Text(weather.hourly[i].weather.first?.weatherDescription ?? "")
                                                    .foregroundColor(Color.white)
                                            }
                                            .padding()
                                                
                                        }
                                            
                                    }
                                }
                                    
                            }
                        }
                        Spacer()
                    }//ZStack
                    .background(Color.black.opacity(1.0))
                    
                }else{
                    Text("エラー")
                }
        }
        
    }
    
    func TempRound(temp:Double) -> String{
        let rounding =  String(round(temp * 10) / 10)
        return rounding
    }
    
}
