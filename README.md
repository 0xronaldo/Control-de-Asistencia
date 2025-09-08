
# Control de Asistencia en Sui
Control de Asistencia es un módulo desarrollado en Move con la blockchain Sui, que permite gestionar el registro de usuarios y su asistencia de forma descentralizada.

Con este contrato inteligente podrás crear controles de asistencia, agregar, actualizar y eliminar personas, así como administrar su presencia y fecha de asistencia, todo con persistencia y verificación de datos en la red.

## Pasos para desplegar en testnet:
1. Contar con tu entorno de Sui client configurando, puedes ver el tutorial en el repositorio de [first steps](https://github.com/Zona-Tres/sui-first-steps/tree/main/extras/sui_client).

2. Posicionarte en la carpeta raiz del proyecto donde tienes el código desarrollado.

3. Hacer el build del código mediante: `sui client build`

**Nota**: Si el buld falla es posiblemente porque el código tenga errores de sintaxis. Para verificarlo antes puedes hacer: `sui move test`.

4. Hacer el push del proyecto a la testnet com: `sui client publish --gas-budget 100000000`

5. Y listo!!!, ya tienes tu proyecto desplegado en la testnet. Como resultado obtendras varios logs, puedes ver el id (`OBJECT-ID`) del paquete en `OBJECT CHANGES` que se encuentra en `PUBLISHED OBJECTS`.

6. Interactua con el paquete. Para ello es necesario usar la siguiente estructura:

```
sui client call --package ID-DEL-PAQUETE --module biblioteca --function NOMBRE-DE-LA-FUNCION --args ARGUENTOS(Si es que la funcion los tiene)
```




## Funciones del modulo

1. `crear_control`

**Descripción**: Crea un nuevo control de asistencia vacío y lo transfiere al creador de la transacción.

---

2. `agregar_persona`

**Descripción**: Agrega una nueva persona al control de asistencia, validando que el ID no exista previamente.

**Argumentos**:

- `control`: Referencia mutable al control de asistencia.
- `identificador`: ID único para la persona.
- `nombre`: Nombre de la persona.
- `presente`: Estado de asistencia (true/false).
- `fecha`: Fecha de la asistencia.

---

3. `actualizar_nombre`

**Descripción**: Cambia el nombre de una persona existente.

**Argumentos**:

- `control`: Referencia mutable al control de asistencia.
- `identificador`: ID de la persona a actualizar.
- `nombre`: Nuevo nombre de la persona.

---

4. `actualizar_asistencia`

**Descripción**: Cambia el estado de asistencia de una persona.

**Argumentos**:

- `control`: Referencia mutable al control de asistencia.
- `identificador`: ID de la persona a actualizar.
- `presente`: Nuevo estado de asistencia (true/false).

---

