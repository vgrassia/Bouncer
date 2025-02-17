//
//  FilterDetailView.swift
//  Bouncer
//

import SwiftUI

struct FilterDetailView<L: View, R: View>: View {
    
    var isEmbedded = true
    var title: String
    var leadingBarItem: L
    var trailingBarItem: R
    
    @Binding var filterType: FilterType
    @Binding var filterDestination: FilterDestination
    @Binding var filterTerm: String
    @Binding var exactMatch: Bool
    @Binding var useRegex: Bool
    
    var body: some View {
        rootView
    }
    
}

extension FilterDetailView {
    
    @ViewBuilder private var rootView: some View {
        if isEmbedded {
            NavigationView {
                form
                    .navigationBarTitle("NEW_FILTER")
                    .navigationBarItems(leading: leadingBarItem, trailing: trailingBarItem)
            }
        } else {
            form
                .navigationBarTitle("UPDATE_FILTER")
                .navigationBarItems(trailing: trailingBarItem)
        }
    }
    
    private var form: some View {
        Form {
            Section(header: Text("FILTER_INFORMATION")) {
                Picker(selection: $filterType, label: Text("FILTER_TYPE_SELECTION_LABEL")) {
                    ForEach(FilterType.allCases, id: \.self) { value in
                        HStack {
                            Image(systemName: value.formDescription.decoration.image).foregroundColor(value.formDescription.decoration.color)
                            Text(value.formDescription.text)
                        }
                    }
                }
                HStack {
                    Text("FILTER_CONTAINS_TEXT_LABEL")
                    Spacer()
                    TextField("FILTER_TEXT_PLACEHOLDER", text: $filterTerm)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.trailing)
                }
                Picker(selection: $filterDestination, label: Text("FILTER_ACTION_LABEL")) {
                    ForEach(FilterDestination.allCases, id: \.self) { value in
                        HStack {
                            Image(systemName: value.formDescription.decoration.image).foregroundColor(value.formDescription.decoration.color)
                            Text(value.formDescription.text)
                        }
                    }
                }
            }
            Section(header: Text("ADVANCED")) {
                Toggle(isOn: $useRegex) {
                    VStack(alignment: .leading) {
                        Text("USE_REGULAR_EXPRESSIONS")
                            .padding(0)
                        Spacer()
                        Text("USE_REGULAR_EXPRESSIONS_DETAIL")
                            .font(.caption)
                            .foregroundColor(Color("TextDefaultColor"))
                    }.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            }
        }
    }
    
}

struct FilterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilterDetailView(title: "Add Filter",
                         leadingBarItem: Text("LBI"),
                         trailingBarItem: Text("RBI"),
                         filterType: .constant(.any),
                         filterDestination: .constant(.transaction),
                         filterTerm: .constant("Query Term"),
                         exactMatch: .constant(false),
                         useRegex: .constant(false))
    }
}
