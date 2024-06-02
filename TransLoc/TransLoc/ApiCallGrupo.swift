//
//  ApiCallGrupo.swift
//  TransLoc
//
//  Created by Student08 on 27/04/23.
//

import Foundation

struct Grupo : Codable, Hashable {
    let nome : String?
}

import Foundation

class ApiCallGrupo: ObservableObject {
    @Published var chars : [Grupo] = []
    
    func fetch() {
        guard let url = URL(string: "http://127.0.0.1:1880/getgrupotl") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([Grupo].self, from: data)
                
                DispatchQueue.main.async {
                    self?.chars = parsed
                }
            } catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    func create(grupo: Grupo) {
            guard let url = URL(string: "http://127.0.0.1:1880/postgrupotl") else {
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST" // Método HTTP para criar um novo objeto
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Definir o tipo de conteúdo do corpo da requisição como JSON
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(grupo) // Codificar o objeto em JSON
                request.httpBody = jsonData // Definir o corpo da requisição como os dados codificados
            } catch {
                print(error)
                return
            }

            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }

                do {
                    let parsed = try JSONDecoder().decode(Grupo.self, from: data) // Decodificar a resposta do servidor em um objeto do tipo Usuario

                    DispatchQueue.main.async {
                        self?.chars.append(parsed) // Adicionar o objeto decodificado ao array de objetos
                    }
                } catch {
                    print(error)
                }
            }

            task.resume()
        }
}
