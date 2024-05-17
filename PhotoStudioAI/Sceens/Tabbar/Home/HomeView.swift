//
//  HomeView.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 22.02.2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State var selectedItem: ProductModel?
    @State var showDetail = false
    @State var showPaywall = false
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Create")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    Task { await viewModel.fetchData() }
                }.fullScreenCover(item: $selectedItem) { product in
                    DetailView(model: product)
                }.fullScreenCover(isPresented: $showPaywall) {
                    PaywallView()
                }
        }.onAppear {
            PayManager.shared.getProductList()
        }
    }
    
}

//MARK: - UI
extension HomeView {
    
    var content: some View {
        listView
    }
    
    var listView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing:0) {
                ForEach(viewModel.sections, id:\.id) { section in
                    
                    //Section
                    HStack {
                        Text(section.title.firstUppercased)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                    
                    
                    //Rows
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(section.getItems(), id:\.id) { item in
                                WebImage(url: URL(string: item.image())) { image in
                                    image.resizable()
                                } placeholder: {
                                    Rectangle().foregroundColor(.gray)
                                }
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                                .onTapGesture {
                                    
                                    if let pro = item.pro, pro {
                                        showPaywall = true
                                        return
                                    }
                                    
                                    selectedItem = item
                                    showDetail = true
                                }.overlay {
                                    let pro = item.pro ?? true
                                    if pro {
                                        proLogo
                                    }else {
                                        EmptyView()
                                    }
                                }
                            }
                        }.padding(.leading, 15)
                    }
                }
            }
        }
    }
    
    var proLogo: some View {
        HStack {
            Spacer()
            VStack {
                Text("Pro")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 1)
                    .padding(.horizontal, 4)
                    .background(
                        Color(.primary).cornerRadius(6)
                    ).padding(4)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func getPlaceHolder() -> some View {
        Rectangle()
            .aspectRatio(contentMode: .fill)
            .foregroundColor(Color.gray)
    }
}



#Preview {
    HomeView()
}
