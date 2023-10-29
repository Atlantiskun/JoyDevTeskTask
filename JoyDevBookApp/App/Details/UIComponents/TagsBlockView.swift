//
//  TagsBlockView.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import DataLayer
import SwiftUI

struct TagsBlockView: View {
    let tags: [String]
    
    var body: some View {
        MultilineHStack(
            items: tags,
            verticalSpacing: 4,
            horizotalSpacing: 6
        ) { tag in
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.secondary)
                
                Text(tag)
                    .foregroundColor(.primary)
                    .font(.title2)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
            }
            .fixedSize()
        }
    }
}

struct TagsBlockView_Previews: PreviewProvider {
    static var previews: some View {
        TagsBlockView(tags: [])
    }
}
