//
//  PartidaView.swift
//  TransLoc
//
//  Created by Student08 on 29/04/23.
//

import SwiftUI

func getTime() -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    let dateString = formatter.string(from: Date())
    return dateString
}

struct PartidaView: View {
    // State
    @StateObject private var notificacao = ApiCallNotificacoes()
    @State var cTime : String = getTime()
    @State var passageiros : [PassageiroCard]
    @State var sConfirmAlert : Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                Text ("Agora São:")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    
                Text(cTime)
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                Spacer()
                    Text("Lista de passageiros não faltantes:")
                        .font(.headline)
                        .foregroundColor(Color.white)
                }.frame(maxHeight: 100.0)
                Divider()
                ScrollView {
                    ForEach(passageiros, id: \.ordem) { passageiro in
                        if !passageiro.faltara {
                            passageiro
                        }
                    }
                    
                }
                VStack {
                    Button ("Iniciar Trajeto") {
                        sConfirmAlert = true
                    }.alert("Confirme o Inicio do Trajeto!", isPresented: $sConfirmAlert) {
                        Button("Cancelar", role: .cancel) {  }
                        Button("Confirmar", role: .none) {
                            var notificacaoIniciar = ApiCallNotificacoes()
                            notificacaoIniciar.create(notificacao: Notificacao(titulo: "Trajeto Iniciado", data: "21:03", corpo: "Corpo da notificação"))
                        }
                    } message: {
                        Text("Você notificará todos os passageiros ao clicar nessa opção")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("SunsetOrange"))
                    .clipShape(RoundedRectangle(cornerRadius: 120))
                }.padding(.vertical, 10.0)
                
                
               
            }
        }.padding().background(Color("WeldonBlue")).onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval:2.0, repeats: true) {
                time in
                cTime = getTime()
            }
         })
    }
}

struct PartidaView_Previews: PreviewProvider {
    static var previews: some View {
        let passageiros = [
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 1),
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 2),
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 3),
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 4),
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 5)]
        PartidaView(passageiros: passageiros)
    }
}
