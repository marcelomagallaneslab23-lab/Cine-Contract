///SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
/** 
 * @title Cine de Terror
 * @author marcelomagallanes-dev
 * @dev Este contrato es para el manejo de peliculas de terror
 * @notice Este contrato es parte del segundo proyecto del Ethereum Developer Pack 
 * @custom:security Este es un contrato educativo y no debe ser usado en producción 
 */ 

contract CineContract {
    /*////////////////////////
        Definicion de estructura de datos
    ////////////////////////*/    

    ///@dev Se usa para almacenar la información de las peliculas que se añaden al contrato|
    ///@param titulo El titulo de la pelicula
    ///@param descripcion La descripcion de la pelicula
    ///@param tiempoDeCreacion El tiempo de creacion de la pelicula en formato unix
            struct Pelicula {
                string titulo;
                string descripcion;
                uint256 tiempoDeCreacion;
                bool agregada;
            }

    /*////////////////////////
        Array para las peliculas
    ////////////////////////*/     

    ///@dev Se usa el array publico para que sea mas facil de acceder a las peliculas
        Pelicula[] public s_peliculas;

    /*////////////////////////
        Events
    ////////////////////////*/     

    ///@dev El evento se emite cuando se añade una nueva pelicula al array de peliculas
    ///@param pelicula La pelicula que fue añadida
        event CineContract_PeliculaCreada(Pelicula pelicula);

    ///@dev El evento se emite cuando se elimina una pelicula del array de peliculas
    ///@param _titulo El titulo de la pelicula que fue eliminada
        event CineContract_PeliculaEliminada(string _titulo); 

    /*////////////////////////
        Functions
    ////////////////////////*/ 

    /*
        *@dev La funcion crea una nueva pelicula y la añade al array de peliculas
        *@param _titulo un titulo para la pelicula
        *param _descripcion una descripcion de la peliucla
    */

    function addPelicula(string memory _titulo , string memory _descripcion) external {
        Pelicula memory newPelicula = Pelicula({
            titulo: _titulo,
            descripcion: _descripcion,
            tiempoDeCreacion: block.timestamp,
            agregada: true
        });

        s_peliculas.push(newPelicula);

        emit CineContract_PeliculaCreada(newPelicula);
    }

    /*
        *@dev La funcion elimina una pelicula de la lista de peliculas
        *@dev Si la pelicula existe, se eliminara de la lista de peliculas
        *@param _titulo titulo de pelicula que se elimina
    */

    function deletePelicula(string memory _titulo) external {
        uint256 tamano = s_peliculas.length;

        for(uint256 i = 0; i < tamano; i++) {
            if(keccak256(abi.encodePacked(_titulo)) == keccak256(abi.encodePacked(s_peliculas[i].titulo))) {
                s_peliculas[i] = s_peliculas[tamano - 1];
                s_peliculas.pop();
                
                emit CineContract_PeliculaEliminada(_titulo);
                return;
            }
        }
    }

    /*
    *@dev La funcion retorna todas las peliculas del array
    *@return Peliculas[] array de peliculas
    */

    function getPeliculas() external view returns (Pelicula[] memory) {
        return s_peliculas;
    }

} 

/**
Contrac ABI

[{"anonymous":false,"inputs":[{"components":
[{"internalType":"string","name":"titulo","type":"string"},
{"internalType":"string","name":"descripcion","type":"string"},
{"internalType":"uint256","name":"tiempoDeCreacion","type":"uint256"},
{"internalType":"bool","name":"agregada","type":"bool"}]
,"indexed":false,"internalType":"struct CineContract.Pelicula","name":"pelicula","type":"tuple"}],
"name":"CineContract_PeliculaCreada","type":"event"},
{"anonymous":false,"inputs":[{"indexed":false,"internalType":"string","name":"_titulo","type":"string"}],
"name":"CineContract_PeliculaEliminada","type":"event"},
{"inputs":[{"internalType":"string","name":"_titulo","type":"string"},
{"internalType":"string","name":"_descripcion","type":"string"}],
"name":"addPelicula","outputs":[],"stateMutability":"nonpayable","type":"function"},
{"inputs":[{"internalType":"string","name":"_titulo","type":"string"}],
"name":"deletePelicula","outputs":[],"stateMutability":"nonpayable","type":"function"},
{"inputs":[],"name":"getPeliculas","outputs":[{"components":
[{"internalType":"string","name":"titulo","type":"string"},
{"internalType":"string","name":"descripcion","type":"string"},
{"internalType":"uint256","name":"tiempoDeCreacion","type":"uint256"},
{"internalType":"bool","name":"agregada","type":"bool"}],
"internalType":"struct CineContract.Pelicula[]","name":"","type":"tuple[]"}],
"stateMutability":"view","type":"function"},{"inputs":
[{"internalType":"uint256","name":"","type":"uint256"}],
"name":"s_peliculas","outputs":[{"internalType":"string","name":"titulo","type":"string"},
{"internalType":"string","name":"descripcion","type":"string"},
{"internalType":"uint256","name":"tiempoDeCreacion","type":"uint256"},
{"internalType":"bool","name":"agregada","type":"bool"}],"stateMutability":"view","type":"function"}]
*/
