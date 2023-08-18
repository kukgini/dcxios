// ExampleCustomDisclosureGroupView.swift

import SwiftUI

struct ExampleCustomDisclosureGroupView: View {
    @EnvironmentObject var model: dcxiosStates
    @State var isExpanded: Bool
    
    var body: some View {
        CustomDisclosureGroup(isExpanded: $isExpanded) {
            isExpanded.toggle()
        } prompt: {
            HStack(spacing: 0) {
                Text("How to open an account in your application?")
                Spacer()
                Text(">")
                    .fontWeight(.bold)
                    .rotationEffect(isExpanded ? Angle(degrees: 90) : .zero)
            }
            .padding(.horizontal, 20)
        } expandedView: {
            Text("you can open an account by choosing between gmail or ICloud when opening the application")
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
        }
    }
}

struct ExampleCustomDisclosureGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleCustomDisclosureGroupView(isExpanded: true)
    }
}
