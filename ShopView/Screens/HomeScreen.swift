//
//  HomeScreen.swift
//  ShopView
//
//  Created by mac on 18.01.2023.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedIndex: Int = 0
    @State private var searchFurniture: String = ""
    private let categories = ["All", "Chair", "Sofa", "Lamp", "Kitchen", "Table"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        AppBarView()
                        
                        TagLineView()
                            .padding()
                        
                        SearchAndScanView(search: $searchFurniture)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< categories.count) { category in
                                    CategoryView(isActive: category == 1, text: categories[category])
                                        .onTapGesture {
                                            selectedIndex = category
                                        }
                                }
                            }
                            .padding()
                        }
                        
                        
                        Text("Populat")
                            .font(.custom("PlayfairDisplay-Bold", size: 24))
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 4) { product in
                                    NavigationLink(destination: {
                                        DetailScreen()
                                    }, label: { ProductCardView(productImage: Image("chair_\(product + 1)"), size: 180)
                                        
                                    })
                                    .navigationBarHidden(true)
                                    .foregroundColor(.black)
                                }
                                .padding(.trailing)
                            }
                            .padding(.horizontal)
                        }
                        
                        
                        Text("Best")
                            .font(.custom("PlayfairDisplay-Bold", size: 24))
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 4) { product in
                                    ProductCardView(productImage: Image("chair_\(product + 1)"), size: 180)
                                }
                                .padding(.trailing)
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                }
                
                // custom tab bar
                
                HStack {
                    TabBarButton(image: Image("home"), action: {})
                    TabBarButton(image: Image("fav"), action: {})
                    TabBarButton(image: Image("shop"), action: {})
                    TabBarButton(image: Image("user"), action: {})
                }
                .padding()
                .background(.white)
                .clipShape(Capsule())
                .padding()
                .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 6)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}


struct AppBarView: View {
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image("menu")
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
            }
            Spacer()
            
            Button(action: {}) {
                Image("profile")
                    .resizable()
                    .frame(width: 42, height: 42, alignment: .center)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
}

struct TagLineView: View {
    var body: some View {
        Text("Find the \nBest ")
            .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary"))
            + Text("Furniture!")
            .font(.custom("PlayfairDisplay-Bold", size: 28))
            .fontWeight(.bold)
            .foregroundColor(Color("Primary"))
    }
}

struct SearchAndScanView: View {
    @Binding var search: String
    var body: some View {
        HStack {
            HStack {
                Image("search")
                    .padding(.trailing, 8)
                TextField("Search Furniture", text: $search)
            }
            .padding(.all, 20)
            .background(Color.white)
            .cornerRadius(10.0)
            .padding(.trailing, 8)
            
            Button(action: {}) {
                Image("scan")
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(10.0)
            }
        }
        .padding(.horizontal)
    }
}

struct CategoryView: View {
    let isActive: Bool
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(isActive ? Color("Primary") : Color.black.opacity(0.5))
            
            if isActive {
                Color("Primary")
                    .frame(width: 15, height: 2)
                    .clipShape(Capsule())
            }
            
        }
        .padding(.trailing)
    }
}

struct ProductCardView: View {
    let productImage: Image
    let size: CGFloat
    
    var body: some View {
        VStack {
            productImage
                .resizable()
                .frame(width: size, height: 200 * (size/210))
                .cornerRadius(10)
            
            Text("Luxury Swedian chair")
                .font(.title3)
                .fontWeight(.bold)
            
            HStack(spacing: 2) {
                ForEach(0 ..< 5) { star in
                    Image("star")
                }
                
                Spacer()
                
                Text("$1299")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
        }
        .frame(width: size)
        .padding()
        .background(.white)
        .cornerRadius(20)
    }
}

struct TabBarButton: View {
    let image: Image
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            image
                .frame(maxWidth: .infinity)
        }
    }
}
