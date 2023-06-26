//
//  Search.swift
//  ListenMusic
//
//  Created by Emanuel on 19/06/23.
//

import SwiftUI
import NavigationTransitions
import SwiftUITrackableScrollView


struct SearchHead : View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Text("Search")
                    .bold()
                    .font(.system(size: 25))
                Spacer()
                Image("camera")
            }
            .font(.system(size: 23))
            .padding(.top, 40)
        }
    }
}

struct MusicGenre: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .aspectRatio(1.5,contentMode: .fit)
            .overlay {
                HStack(alignment: .top, spacing: 0) {
                    Text("Made for you")
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                        .padding(EdgeInsets(top: 10, leading: 7, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(alignment: .trailing) {
                        Spacer()
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.red)
                            .frame(width: 90, height: 90)
                            .rotationEffect(.degrees(30))
                            .offset(CGSize(width: 20, height: 0))
                    }
                }
            }
            .clipped()
    }
}

struct SearchView: View {
    @State var input = ""
    @State var path = NavigationPath()
    @State var scroll = CGFloat.zero
    @State var position = CGFloat.zero
    var body: some View {
        NavigationStack {
            TrackableScrollView(contentOffset: $scroll) {
                VStack(alignment: .leading) {
                    
                    SearchHead()
                    
                    VStack {
                        NavigationLink {
                            Search2()
                        } label: {
                            HStack {
                                Image("search")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.black)
                                    .frame(width: 25, height: 25)
                                Text("What do you want to listen to?")
                                    .foregroundColor(.black)
                                    .cornerRadius(5)
                                    .font(.system(size: 15))
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(.white)
                            .cornerRadius(7)
                        }
                        .padding(.vertical, 15)
                        .background(CustomColors.primary)
                        .offset(CGSize(width: 0, height: scroll > 87 ? scroll - 87 : 0))
                    }
                    .zIndex(1)

                    Text("Browse All")
                        .bold()
                        .font(.system(size: 17))
                        .padding(.vertical, 10)
                    
                    Grid(horizontalSpacing: 15, verticalSpacing: 15) {
                        ForEach(0...7, id: \.self) { _ in
                            GridRow {
                                ForEach(0...1, id: \.self){ _ in
                                    MusicGenre()
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 95)
                .padding(.horizontal)
            }
            .ignoresSafeArea(edges: .bottom)
            .clipped()
            .background(CustomColors.primary)
        }
        .navigationTransition(.fade(.in).animation(.linear(duration: 0.1)))
    }
}

struct Search2: View {
    @State var input = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                HStack(spacing: 20) {
                    HStack {
                        Image("search")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 16, height: 16)
                        TextField(
                            "",
                            text: $input,
                            prompt:
                                Text("What do you want to listen to?")
                                    .foregroundColor(.gray)
                        )
                        .foregroundColor(.gray)
                        .cornerRadius(5)
                        .font(.system(size: 15))
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .background(Color(red: 0.14, green: 0.14, blue: 0.14))
                    .cornerRadius(7)
                    
                    Button {
                        dismiss.callAsFunction()

                    } label: {
                        Text("Cancel")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, geo.safeAreaInsets.top)
                .padding(.horizontal)
                .padding(.bottom, 8)
                .zIndex(1)
                .background(CustomColors.secondary)
                .ignoresSafeArea(edges: .top)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Recent searches")
                            .bold()
                            .font(.system(size: 18))
                            .padding(.vertical, 10)
                        
                        ForEach(0...9, id: \.self) { _ in
                            HStack {
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: 45, height: 45)
                                VStack(alignment: .leading) {
                                    Text("Nome da música")
                                        .font(.system(size: 15))
                                        .bold()
                                    Text("Nome do artista")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13))
                                }
                                Spacer()
                                Image("close")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .frame(width: 25, height: 25)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, geo.safeAreaInsets.top)
                }
            }
        }
        .background(CustomColors.primary)

        .navigationBarBackButtonHidden()
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedPage: .search)
            .preferredColorScheme(.dark)
    }
}
