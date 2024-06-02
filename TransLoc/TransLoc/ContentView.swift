//
//  ContentView.swift (TelaLogin)
//  TransLoc
//
//  Created by Student07 on 26/04/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var usuario = ApiCallUsuario()
    // Declaração de variáveis
    @State var email: String = ""
    @State var senha: String = ""
    @State var tela: String = ""
    
    @State private var showingWrongCred = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Compass")
                    .resizable()
                    .padding(.bottom, 0.0)
                    .frame(width: 500, height: 500)
                    .opacity(0.3)
                    
                VStack {
                    Text("Login")
                        .font(.system(size: 72))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Group {
                        TextField("E-mail", text: $email)
                        SecureField("Senha", text: $senha)
                        
                    }.padding(.horizontal, 75.0)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .autocapitalization(.none)
                    
                    
                    HStack(){
                        NavigationLink("Criar Conta") {
                            TelaCriarConta()
                        }.foregroundColor(Color(.white))
                            .font(.title2)
                        
                        
                        Image(systemName: "arrowshape.right.fill")
                            .foregroundColor(Color(.white))
                    }
                    .padding([.top, .leading], 20.0)
                    
                    
                    Spacer()
                    
                    
                    ForEach(usuario.chars, id: \.self) { u in
                        if email == u.email && senha == u.password {
                            
                            ZStack(alignment:  .bottomTrailing) {
                                
                                if u.motorista == true {
                                    Circle()
                                        .foregroundColor(Color("StormCloud"))
                                        .frame(width: 100, height: 100)
                                    
                                    
                                    NavigationLink("Entrar") {
                                        TelaHomeMotorista()
                                        
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 100)
                                } else {
                                    // Inserir botão de login quando a TelaHomeCliente estiver pronta
                                }
                                
                                
                                
                                
                                
                            }
                            
                        }
                    }.background(Color("WeldonBlue"))
                    
                    
                }.onAppear() {
                    usuario.fetch()
                }
                
                
                
            }.background((Color("WeldonBlue")))
        }.tint(Color(.white))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

