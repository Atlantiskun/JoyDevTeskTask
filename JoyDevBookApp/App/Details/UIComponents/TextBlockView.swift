//
//  TextBlockView.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import SwiftUI

struct TextBlockView: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppConstants.Padding.medium) {
            Text(title)
                .font(.title2)
                .foregroundColor(.primary)
            
            Text(text)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
}

struct TextBlockView_Previews: PreviewProvider {
    static var previews: some View {
        TextBlockView(title: "", text: "")
    }
}
