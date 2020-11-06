//
//  ViewController.swift
//  iBuy
//
//  Created by Cesar A. Tavares on 04/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewProducts: UITableView!
    @IBOutlet weak var searchBarProducts: UISearchBar!
        
    var arrayProducts = [Products]()
    var arrayPendingList = [Products]()
    var arrayCompletedList = [Products]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarProducts.delegate = self
        
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
        
        arrayProducts.append(Products(name: "Batata", completed: true))
        arrayProducts.append(Products(name: "Cenoura", completed: false))
        
        loadProducts()
    }
    
    
    @IBAction func actionButtonAdd(_ sender: Any) {
        let title: String = "Cadastro"
        showAllert(title: title, product: nil)
    }
    
    
    func loadProducts() {
        arrayCompletedList = arrayProducts.filter({ (product) -> Bool in
            return product.completed
        })
        
        arrayPendingList = arrayProducts.filter({ (product) -> Bool in
            return !product.completed
        })
        
        tableViewProducts.reloadData()
    }
    
    
    func checkProductStatus(product: String) -> Bool {
        for item in arrayProducts {
            if item.name.folding(options: .diacriticInsensitive, locale: .current).lowercased() == product.folding(options: .diacriticInsensitive, locale: .current).lowercased() {
                item.completed = !item.completed
                loadProducts()
                return true
            }
        }
        return false
    }
    
    
    func editProductStatus(product: Products) {
        for item in arrayProducts {
            if item.name == product.name {
                item.completed = !item.completed
            }
        }
        loadProducts()
    }
    
    
    func editSelectProduct(product: Products) {
        let title: String = "Editar"
        showAllert(title: title, product: product)
    }
    
    
    func editProduct(productEdited: String, product: Products) {
        for item in arrayProducts {
            if item.name == product.name {
                item.name = productEdited
            }
        }
        loadProducts()
    }
    
    
    func addProduct(product: String) {
        arrayProducts.append(Products(name: product, completed: false))
        loadProducts()
    }
    
    
    func deleteProduct(product: Products) {
        
        var count: Int = 0
        
        for item in arrayProducts {
            if item.name == product.name {
                arrayProducts.remove(at: count)
            } else {
                count = count + 1
            }
        }
        loadProducts()
    }
    
    
    func searchProduct(product: String) {
        var arrayProductsFiltred = [Products]()
        
        for item in arrayProducts {
            if item.getProduct().folding(options: .diacriticInsensitive, locale: .current).lowercased().contains(product.folding(options: .diacriticInsensitive, locale: .current).lowercased()) {
                
                arrayProductsFiltred.append(item)
                
                arrayPendingList.removeAll()
                arrayCompletedList.removeAll()
                
                arrayPendingList = arrayProductsFiltred.filter({ (pending) -> Bool in
                    return !pending.completed
                })
                
                arrayCompletedList = arrayProductsFiltred.filter({ (completed) -> Bool in
                    return completed.completed
                })
                
                tableViewProducts.isHidden = false
                tableViewProducts.reloadData()
            } else {
                tableViewProducts.isHidden = true
            }
            
        }
    }
    
    
    func showAllert(title: String, product: Products?) {
        if title == "Cadastro" || title == "Editar" {
            let alert = UIAlertController(title: title, message: "Digite o nome do Produto", preferredStyle: .alert)
            alert.addTextField { (textField) in
                if title == "Cadastro" {
                    textField.placeholder = "Ex.: Maçã"
                } else {
                    textField.text = product?.name
                }
            }
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default))
                
            alert.addAction(UIAlertAction(title: "Salvar", style: .default) { (save) in
                if title == "Cadastro" {
                    if let textField = alert.textFields?.first, let text = textField.text {
                        if self.checkProductStatus(product: text) { } else {
                            self.addProduct(product: text)
                        }
                    }
                } else {
                    if let textField = alert.textFields?.first, let text = textField.text {
                        self.editProduct(productEdited: text, product: product!)
                    }
                }
            })
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Tem certeza que deseja apagar este item?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Sim", style: .default){ (yes) in
                self.deleteProduct(product: product!)
            })
            
            alert.addAction(UIAlertAction(title: "Não", style: .cancel))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func showActionSheet(product: Products) {
        let pending: String = "Marcar como concluído"
        let completed: String = "Marcar como aberto"
        
        let alert = UIAlertController(title: "Selecione a opção desejada", message: "", preferredStyle: .actionSheet)
        
        if !product.completed {
            alert.addAction(UIAlertAction(title: pending, style: .default){ (edit) in
                self.editProductStatus(product: product)
            })
        } else {
            alert.addAction(UIAlertAction(title: completed, style: .default){ (edit) in
                self.editProductStatus(product: product)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Editar", style: .default){ (edit) in
            self.editSelectProduct(product: product)
        })
        
        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive){ (delete) in
            self.showAllert(title: "Atenção", product: product)
        })
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            showActionSheet(product: arrayPendingList[indexPath.row])
        } else {
            showActionSheet(product: arrayCompletedList[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Abertos"
        }
        return "Concluídos"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arrayPendingList.count
        }
        return arrayCompletedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        if indexPath.section == 0 {
            cell.setup(product: arrayPendingList[indexPath.row])
        } else {
            cell.setup(product: arrayCompletedList[indexPath.row])
        }
        return cell
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let product = searchBar.text {
            if product == ""{
                tableViewProducts.isHidden = false
                loadProducts()
            } else {
                searchProduct(product: product)
            }
        }
    }
}
