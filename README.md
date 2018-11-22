# Quiz
Enunciado
En la asignatura CORE del año pasado se desarrolló un servicio web llamado Quiz que permitía introducir preguntas para luego jugar a acertarlas.

En la página https://quiz2019.herokuapp.com está desplegado este servicio. Los alumnos pueden entrar en este sitio web con un navegador para usar este servicio.

El objetivo de esta práctica es crear una app iOS usando el lenguaje Swift que muestre un listado con todos los quizzes existentes, y que permita jugar a responderlos correctamente.

Una posible implementación de esta app sería la mostrada en las siguientes imágenes. Una página inicial muestra el listado de todos los quizzes en una table. Seleccionando un quiz de este listado se pasa a la segunda pantalla, donde se puede escribir la respuesta del quiz seleccionado y comprobar si es correcta. Desde la segunda pantalla se puede acceder a una tercera pantalla que muestra las pistas existentes para acertar la pregunta.

Listado de quizzesResponder QuizPistas

El código de este servicio web (implementado con node y express) está disponible en https://github.com/CORE-UPM/CRM_2017.git. El alumno puede consultar este código para ver los detalles de la implementación del API REST.

El alumno debe diseñar esta app creando las pantallas que desee, y usando los mecanismos de navegación entre pantallas que considere adecuados. Sin embargo, el listado de todos los quizzes debe mostrarse usando vistas del tipo Table View.

Adicionalmente, la app debe cumplir con los siguientes requisitos:

Debe usarse GCD para que la aplicación responda suavemente en todo momento, evitando los bloqueos que se producen al esperar a que los datos a mostrar hayan sido descargados.
Debe comportarse adecuadamente cuando no haya conexión con el servidor.
Debe visualizarse correctamente en cualquier tipo de terminal, y para cualquier orientación de la pantalla.
Usar iconos (desktop, etc..) y pantalla de inicio. 
Para poder utilizar el API REST del servicio web, es necesario que los alumnos se creen una cuenta y se creen un token de acceso. También pueden usar una de las cuentas ya existentes si conocen cuál es su token de acceso. Este token se utilizará en todas las peticiones que se envíen al servidor. El token se puede crear o cambiar entrando en el portal web, haciendo login, entrando en el perfil de usuario (esquina superior derecha), y solicitando que se genere un nuevo token de acceso. 

En el moodle de la asignatura existe un documento pdf donde se describen todas las primitivas del API REST del servidor Quiz. Todas las peticiones descritas descargan un JSON diferente, pero para un mismo tipo de petición, el JSON devuelto tiene siempre los mismos campos. Use un navegador para probar las peticiones y ver formato de los JSONs devueltos. Para ver cómodamente el contenido y la estructura de los JSONs descargados, se recomienda instalar en su navegador alguna extensión para formatear documentos JSON.

Parte Opcional
Convertir las estrellas en botones que permitan marcar o desmarcar un quiz como favorito.

