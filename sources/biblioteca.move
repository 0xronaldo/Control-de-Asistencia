module biblioteca::biblioteca {
    use sui::vec_map::{Self, VecMap};
    use std::string::String;

    // * Estructuras
    public struct Biblioteca has key, store {
        id: UID,
        libros: VecMap<u64, Libro>,
    }

    public struct Libro has copy, drop, store {
        titulo: String,
        autor: String,
        publicado: u16,
        disponible: bool,
    }

    // * Códigos de error
    const ID_YA_EXISTE: u64 = 10;
    const ID_NO_EXISTE: u64 = 11;

    // * Funciones
    #[allow(lint(self_transfer))]
    public fun crear_biblioteca(ctx: &mut TxContext) {
        let libros = vec_map::empty();

        let biblioteca = Biblioteca {
            id: object::new(ctx),
            libros,
        };

        transfer::transfer(biblioteca, tx_context::sender(ctx));
    }

    // * Agrega un libro con los datos proporcionados.
    public fun agregar_libro(biblioteca: &mut Biblioteca, identificador: u64, titulo: String, autor: String, publicado: u16, disponible: bool) {
        let libro = Libro { titulo, autor, publicado, disponible };

        assert!(!biblioteca.libros.contains(&identificador), ID_YA_EXISTE);

        biblioteca.libros.insert(identificador, libro)
    }

    // * Actualiza el titulo de un libro en base a los datos proporcionados
    public fun actualizar_titulo(biblioteca: &mut Biblioteca, identificador: u64, titulo: String) {
        assert!(biblioteca.libros.contains(&identificador), ID_NO_EXISTE);

        let titulo_actual = &mut biblioteca.libros.get_mut(&identificador).titulo;
        *titulo_actual = titulo;
    }

    // * Actualiza el autor de un libro en base a los datos proporcionados
    public fun actualizar_autor(biblioteca: &mut Biblioteca, identificador: u64, autor: String) {
        assert!(biblioteca.libros.contains(&identificador), ID_NO_EXISTE);

        let autor_actual = &mut biblioteca.libros.get_mut(&identificador).autor;
        *autor_actual = autor;
    }

    // * Actualiza el año de publicación de un libro en base a los datos proporcionados
    public fun actualizar_publicado(biblioteca: &mut Biblioteca, identificador: u64, publicado: u16) {
        assert!(biblioteca.libros.contains(&identificador), ID_NO_EXISTE);

        let publicado_actual = &mut biblioteca.libros.get_mut(&identificador).publicado;
        *publicado_actual = publicado;
    }

    // * Actualiza si un libro está disponible o no en base a los datos proporcionados
    public fun actualizar_disponibilidad(biblioteca: &mut Biblioteca, identificador: u64, disponible: bool) {
        assert!(biblioteca.libros.contains(&identificador), ID_NO_EXISTE);

        let disponibilidad_actual = &mut biblioteca.libros.get_mut(&identificador).disponible;
        *disponibilidad_actual = disponible;
    }

    // * Borra un libro de la biblioteca en base al ID proporcionado
    public fun borrar_libro(biblioteca: &mut Biblioteca, identificador: u64) {
        assert!(biblioteca.libros.contains(&identificador), ID_NO_EXISTE);

        biblioteca.libros.remove(&identificador);
    }

    // * Borrar la biblioteca completa
    public fun eliminar_biblioteca(biblioteca: Biblioteca) {
        let Biblioteca { id, libros: _ } = biblioteca;
        id.delete();
    }

}
