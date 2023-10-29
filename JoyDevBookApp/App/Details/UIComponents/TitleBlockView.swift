//
//  TitleBlockView.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import SwiftUI

struct TitleBlockView: View {
    let name: String

    var body: some View {
        Text(name)
            .font(.largeTitle)
    }
}

struct TitleBlockView_Previews: PreviewProvider {
    static var previews: some View {
        TitleBlockView(name: "")
    }
}
