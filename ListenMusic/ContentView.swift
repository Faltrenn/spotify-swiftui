//
//  ContentView.swift
//  ListenMusic
//
//  Created by Emanuel Alves de Medeiros on 13/06/23.
//

import SwiftUI

struct Env {
    static let ips = [
        "http://192.168.0.101:8000",
        "http://127.0.0.1:8000",
        "http://172.20.10.11:8000",
        "http://192.168.0.106:8000"
    ]
    
    static let apiUrl = ips[1]
}

struct CustomColors {
    static let cards = Color("Card")
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let terciary = Color("Tertiary")
}

struct Main {
    static let screen = UIScreen.main.bounds.size
    struct spaces {
        static let horizontal: CGFloat = 16
    }
}

enum TabbedPages: Int, CaseIterable {
    case home = 0
    case search
    case library
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .library:
            return "Your library"
        }
    }
    
    var unselectedIcon: String {
        switch self {
        case .home:
            return "home"
        case .search:
            return "search"
        case .library:
            return "library"
        }
    }
    var selectedIcon: String {
        switch self {
        case .home:
            return "home.fill"
        case .search:
            return "search.fill"
        case .library:
            return "library.fill"
        }
    }
}

struct ContentView: View {
    @State var selectedPage: TabbedPages = .home
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                switch selectedPage {
                case .home:
                    HomeView()
                case .search:
                    SearchView()
                case .library:
                    LibraryView()
                }
            }
            
            HStack(alignment: .top) {
                ForEach(TabbedPages.allCases, id: \.self) { page in
                    VStack {
                        Image(page == selectedPage ? page.selectedIcon : page.unselectedIcon)
                            .renderingMode(.template)
                        Text(page.title)
                            .font(.system(size: 10))
                    }
                    .foregroundColor(selectedPage == page ? .white : .gray)
                    .onTapGesture {
                        selectedPage = page
                    }
                    if page != TabbedPages.allCases.last {
                        Spacer()
                    }
                }
            }
            .padding(.top, 15)
            .padding(.horizontal, 50)
            .frame(height: 95, alignment: .top)
            .background(LinearGradient(colors: [CustomColors.primary.opacity(0.9),  CustomColors.primary], startPoint: .top, endPoint: .center))
        }
        .ignoresSafeArea(edges: .bottom)
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedPage: .home)
            .environmentObject(AudioManager())
    }
}
