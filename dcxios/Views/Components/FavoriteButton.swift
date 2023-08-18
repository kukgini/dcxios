// FavoriteButton.swift

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
        // [Important] buttonStyle needed for SwiftUI bug:
        // https://stackoverflow.com/questions/63087817/strange-buttons-behaviour-in-a-list-swiftui
        .buttonStyle(BorderlessButtonStyle())
//        .padding(10)
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(lineWidth: 0)
//                .foregroundColor(Color.blue)
//        )
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
