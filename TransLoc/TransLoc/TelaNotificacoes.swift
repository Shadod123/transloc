//
//  TelaNotificacoes.swift
//  TransLoc
//
//  Created by Student04 on 09/05/23.
//

import SwiftUI

struct TelaNotificacoes: View {
    @StateObject private var notificacao = ApiCallNotificacoes()
    @State var titulo: String = ""
    @State var data: String = ""
    @State var corpo: String = ""
    
    var body: some View {
        ZStack{
            Color("WeldonBlue").ignoresSafeArea()
            VStack {
                HStack {
                    Spacer().frame(width: 90)
                    Text("Notificações")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                    Spacer().frame(width: 35)
                    Button(action: {
                        notificacao.fetch()
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(Color.white)
                            .font(.title2)
                    }
                    .padding()
                }
                List(notificacao.chars, id: \.self) { notification in
                    VStack(alignment: .leading) {
                        HStack{
                            Text(notification.titulo ?? "")
                                .fontWeight(.bold)
                            Spacer()
                            Text(notification.data ?? "")
                                .opacity(0.5)
                        }.padding(.bottom)
                        Text(notification.corpo ?? "")
                    }
                }
                .onAppear {
                    notificacao.fetch()
                }
            }
        }
    }
}

struct TelaNotificacoes_Previews: PreviewProvider {
    static var previews: some View {
        TelaNotificacoes()
    }
}
