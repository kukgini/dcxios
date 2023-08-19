import SwiftUI

struct SearchBar: View {
    @State var text: String = ""
    var complition: (String) -> Void
    @State private var isEditing = false
        
    var body: some View {
        HStack {
            
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.hideKeyboard()
                                self.complition(self.text)
                            }) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .padding(.trailing, 1)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.text = ""
                                self.hideKeyboard()
                                self.complition(self.text)
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.red)
                                    .padding(.trailing, 8)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                )
                .padding(.horizontal, 10)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .onTapGesture {
                    self.isEditing = true
                }
                .onSubmit {
                    self.complition(self.text)
                }
        }
    }
}
