//
//  ViewController.swift
//  Clase35ServicioWebTableView
//
//  Created by Escurra Colquis on 27/11/24.
//

import UIKit //importamos UI

//ViewController clase padre en el cual hereda los delegados del UITableView
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //componentes de la UI
    @IBOutlet weak var listTableView: UITableView!
    
    //variables
    var arrayRecipe = [RecipeResponse]() //array de tipo RecipeResponse, lo inicializamos vacio porque se carga vacio en primer lugar y luego ya le vamos a asignar datos cuando llamemos al servicio
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView() //llamamos a la función de la configuración de la tabla
        fetchData() //llamamos a la función del servicio
    }
    
    //funciones
    //configuramos la tabla
    func configureTableView() {
        listTableView.delegate = self //delegado
        listTableView.dataSource = self //datasource
        listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell") //registramos el nombre de la celda en la tabla
        listTableView.rowHeight = 200 //tamaño de la celda
        listTableView.showsVerticalScrollIndicator = false //esconder la barra del scroll vertical
        listTableView.separatorStyle = .none //hacemos un separador
    }
    
    //función para listar a la lista
    func fetchData() {
        let webService = "https://demo6693165.mockable.io/getRecipes" //esta url es el servicio web que viene en objetos JSON
        //debemos de pasarlo a url propio de swift
        guard let url = URL(string: webService) else {
            return
        }
        //Aca usamos la magia de la librería nativa de Apple en swift el URLSession que vamos a tener 3 parametros: data para los datos del servicio es decir el JSON, response para la respuesta del servicio y el error si es que hay
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            //en un guard ponemos las respuestas del serivicios que son correctas del 200 al 299 y si no que haya un error: Por ejemplo un error de servicio 500 (no se puede conectar al servicio o alteramos la ruta url)
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                print("Error general: \(String(describing: error?.localizedDescription))") //por el momento solo imprimos por consola el error pero podemos hacer un vista en específica
                return //retornamos ya que es guard
            }
            
            //en un capturador Do-Catch
            do {
                //un guard al data para que no sea forced Ungraping
                guard let dataJSON = data else {
                    return
                }
                //acá parsemos los datos json a Swift, es decir con esa linea de código hacemos la conversión y le ponemos al array de la lista para que se muestre los datos que viene del servicio
                self?.arrayRecipe = try JSONDecoder().decode([RecipeResponse].self, from: dataJSON)
                //dentro de un DispatchQueue para que se ejecute en el hilo principal los componentes de la UI
                DispatchQueue.main.async {
                    self?.listTableView.reloadData() //actualizamos la tablaView
                }
            } catch {
                print("Error al parsear datos") //por el momento solo imprimos por consola el error pero podemos hacer un vista en específica
            }
            
        }.resume() //debe de ir el resume para que se ejecute
    }
    
    // UITableViewDelegate - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        //retornamos uno porque solo hay un table view
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //retornamos la cantidad del arreglo de la lista
        return arrayRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //llamamos a la celda
        let cell = listTableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell
        let list = arrayRecipe[indexPath.row] //pasamos lo que hay en el arreglo de la lista
        cell?.configureView(viewList: list) //configuramos la celda pasandole la lista
        return cell ?? UITableViewCell() //retornamos la celda
    }
}
