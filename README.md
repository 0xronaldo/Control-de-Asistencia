# Control de Asistencia en Sui
Control de Asistencia es un módulo desarrollado en Move con la blockchain Sui, que permite gestionar el registro de usuarios y su asistencia de forma descentralizada.

Con este contrato inteligente podrás crear controles de asistencia, agregar, actualizar y eliminar personas, así como administrar su presencia y fecha de asistencia, todo con persistencia y verificación de datos en la red.



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

