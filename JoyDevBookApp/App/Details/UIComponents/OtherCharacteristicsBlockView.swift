//
//  OtherCharacteristicsBlockView.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import DataLayer
import SwiftUI

struct OtherCharacteristicsBlockView: View {
    let details: CatDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppConstants.Padding.small) {
            if details.weight != nil || details.lifeSpan != nil {
                Text("Other characteristics")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            if let weight = details.weight {
                HStack {
                    Text("Weight")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(weight) kg")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            
            if let lifeSpan = details.lifeSpan {
                HStack {
                    Text("Life Span")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(lifeSpan) years")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct OtherCharacteristicsBlockView_Previews: PreviewProvider {
    static var previews: some View {
        OtherCharacteristicsBlockView(details: CatDetails())
    }
}
