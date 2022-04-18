//
//  ToDayTextView.swift
//  Weather_24
//
//  Created by cmStudent on 2022/01/10.
//

import SwiftUI

struct ToDayTextView: View {
    let textStr:String
    var body: some View {
            Text(textStr)
                .font(.title)
                .foregroundColor(.white)
    }
}

struct ToDayTextView_Previews: PreviewProvider {
    static var previews: some View {
        ToDayTextView(textStr: "test")
    }
}
