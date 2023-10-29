//
//  MultilineHStack.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import SwiftUI

public struct MultilineHStack<Item, ItemView: View>: View {
    let items: [Item]
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    @ViewBuilder let viewMapping: (Item) -> ItemView
    @State private var totalHeight: CGFloat

    public init(items: [Item], verticalSpacing: CGFloat = 0, horizotalSpacing: CGFloat = 0, @ViewBuilder viewMapping: @escaping (Item) -> ItemView) {
        self.items = items
        self.verticalSpacing = verticalSpacing
        horizontalSpacing = horizotalSpacing
        self.viewMapping = viewMapping
        _totalHeight = State(initialValue: .zero)
    }

    public var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                self.content(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func content(in geometry: GeometryProxy) -> some View {
        var width: CGFloat = .zero
        var height: CGFloat = .zero
        var lastHeight: CGFloat = .zero
        let itemCount: Int = items.count

        return ZStack(alignment: .topLeading) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                viewMapping(item)
                    .padding([.bottom], verticalSpacing)
                    .alignmentGuide(.leading, computeValue: { demension in
                        if abs(width - demension.width) > geometry.size.width {
                            width = 0
                            height -= lastHeight
                        }
                        lastHeight = demension.height
                        let result = width
                        if index == itemCount - 1 {
                            width = 0
                        } else {
                            width -= demension.width + horizontalSpacing
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if index == itemCount - 1 {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry in
            Color.clear
                .onAppear {
                    binding.wrappedValue = geometry.frame(in: .local).size.height
                }
        }
    }
}

struct SMultilineHStack_Previews: PreviewProvider {
    static var previews: some View {
        let items: [String] = ["Green", "Red", "Blue", "Cyan", "Black", "Purple", "White", "Orange"]
        MultilineHStack(items: items, verticalSpacing: 10, horizotalSpacing: 10) { item in
            Text(item)
                .padding(10)
                .background(Color.black)
                .foregroundColor(.white)
        }
        .padding()
    }
}
