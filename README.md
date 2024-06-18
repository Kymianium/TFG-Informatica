# Sistema gestor de medallas

Esta aplicación permite la ejecución de un sistema gestor de medallas. Para
ejecutarlo, se debe de ejecutar en primer lugar el simulador Python y,
finalmente, la aplicación de medallas.

## Simulador

Es necesario tener instalado Python 3.12 para ejecutar el simulador. Se puede
descargar de la siguiente página web oficial:
<https://www.python.org/downloads/>

Se recomienda utilizar un entorno virtual para la ejecución de la aplicación.
Para ello, se deben de ejecutar los siguientes comandos:

```bash python3.12 -m venv .venv source .venv/bin/activate```

Las librerías necesarias pueden ser encontradas en ```requirements.txt```. Para
instalarlas, se debe de ejecutar el siguiente comando:

```bash pip install -r requirements.txt```

### Ejecución de la aplicación

Para ejecutar la aplicación, se debe de ejecutar el siguiente comando:

```bash python main.py```

### Uso

El simulador proporciona un menú con las siguientes opciones:

1. Añadir desafíos: Se le pedirá que introduzca el número de desafíos que desea
   añadir.
2. Añadir estudiantes: Se le pedirá que introduzca el número de estudiantes que
   desea añadir.
3. Iniciar simulación: Se le pedirá que introduzca el número de días para que
   la simulación se ejecute.
4. Salir: Esto cerrará el programa.

## Aplicación de medallas

Es necesario tener instalado Flutter y Chrome para ejecutar la aplicación de
medallas. Se pueden descargar ambos de las siguientes páginas web oficiales:

<https://flutter.dev/docs/get-started/install> <https://www.google.com/chrome/>

### Ejecución

Para ejecutar la aplicación de medallas, en el directorio /medallas se debe
ejecutar el comando:

```bash flutter run```

y seleccionar la opción Chrome.

### Uso del front

Desde la maqueta, se pueden generar medallas y consultar las medallas
generadas.

- Si se selecciona la opción de generar medallas, se le pedirá que introduzca
el nombre, un color, una descripción y las condiciones que se tienen que
cumplir para otorgar la medalla.

- Si se selecciona la opción de consultar medallas, se mostrarán todas las
medallas generadas. Pulsando en las medallas, se mostrará la lista de
ganadores.

Desde la pantalla principal, se reciben notificaciones de creaciones de nuevos
retobs u obtenciones de medallas.
