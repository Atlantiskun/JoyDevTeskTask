//
//  DetailsView.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import DataLayer
import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    @State var details: CatDetails?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppConstants.Padding.large) {
                WebImage(url: URL(string: details?.imageUrl ?? ""))
                    .placeholder(Image("catPlaceholder"))
                    .resizable()
                    .scaledToFit()

                if let name = details?.name {
                    TitleBlockView(name: name)
                }
                
                if let details, !details.tags.isEmpty {
                    TagsBlockView(tags: details.tags)
                }
                
                if let description = details?.descrription {
                    TextBlockView(title: "Description", text: description)
                }

                if let temperament = details?.temperament {
                    TextBlockView(title: "Temperament", text: temperament)
                }
                
                if let details {
                    OtherCharacteristicsBlockView(details: details)
                }
            }
            .padding(.horizontal, AppConstants.Padding.medium)
            .padding(.bottom, AppConstants.Padding.medium)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(details: nil)
    }
}
