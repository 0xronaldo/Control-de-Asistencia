// * By: Ronaldo Sanchez Mendoza
// * Control de asistencia : para este proyecto lo construi en vscode ya que el code space tenia problema pero actualizando ciertos servicios si funciono
// * Desarrolle un control basico pero suficiente control de asistencia en donde se registran el nombre , ID , fecha de un usuario con estos datos son suficientes para poder 
// * construir un base de datos tambien la idea que tengo tambien es poder implementar aparte sui + tableland para un sistema ORM basico aun no se si funcione la logica de web2 a web3 
// * pero es un avance


module asistencia::control {
    use sui::vec_map::{Self, VecMap};
    use std::string::String;

    // * Estructuras
    public struct ControlAsistencia has key, store {
        id: UID,
        personas: VecMap<u64, Persona>,
    }

    public struct Persona has copy, drop, store {
        nombre: String,
        presente: bool,
        fecha: String,
    }

    // * Códigos de error
    const ID_YA_EXISTE: u64 = 10;
    const ID_NO_EXISTE: u64 = 11;

    // * Funciones
    #[allow(lint(self_transfer))]
    public fun crear_control(ctx: &mut TxContext) {
        let personas = vec_map::empty();

        let control = ControlAsistencia {
            id: object::new(ctx),
            personas,
        };
    

        transfer::transfer(control, tx_context::sender(ctx));
    }

    // * Agrega una persona con los datos proporcionados.
    public fun agregar_persona(control: &mut ControlAsistencia, identificador: u64, nombre: String, presente: bool, fecha: String) {
        let persona = Persona { nombre, presente, fecha };

        assert!(!control.personas.contains(&identificador), ID_YA_EXISTE);

        control.personas.insert(identificador, persona)
    }

    // * Actualiza el nombre de una persona
    public fun actualizar_nombre(control: &mut ControlAsistencia, identificador: u64, nombre: String) {
        assert!(control.personas.contains(&identificador), ID_NO_EXISTE);

        let nombre_actual = &mut control.personas.get_mut(&identificador).nombre;
        *nombre_actual = nombre;
    }

    // * Actualiza la asistencia de una persona
    public fun actualizar_asistencia(control: &mut ControlAsistencia, identificador: u64, presente: bool) {
        assert!(control.personas.contains(&identificador), ID_NO_EXISTE);

        let presente_actual = &mut control.personas.get_mut(&identificador).presente;
        *presente_actual = presente;
    }

    // * Actualiza la fecha de asistencia de una persona
    public fun actualizar_fecha(control: &mut ControlAsistencia, identificador: u64, fecha: String) {
        assert!(control.personas.contains(&identificador), ID_NO_EXISTE);

        let fecha_actual = &mut control.personas.get_mut(&identificador).fecha;
        *fecha_actual = fecha;
    }

    // * Borra una persona del control de asistencia
    public fun borrar_persona(control: &mut ControlAsistencia, identificador: u64) {
        assert!(control.personas.contains(&identificador), ID_NO_EXISTE);

        control.personas.remove(&identificador);
    }

    // * Elimina el control de asistencia completo
    
    public fun eliminar_control(control: ControlAsistencia) {
        let ControlAsistencia { id, personas: _ } = control;
        id.delete();
    }
}