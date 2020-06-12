# Doctor Whatson

Aplicación para autoevaluarse en diferentes temas de salud, entre ellos Covid-19. Tambien cuenta con un calendario para llevar un seguimiento de sintomas.

La aplicación es completamente anónima y solo almacena datos en su dispositivo. 

Puede ver una [demo para la versión web aquí](https://ftenaf.github.io/drwhatson/#/)

![Pagina principal](doc/img/ui.gif)

Actualmente y para abaratar costes y no depender de terceros (gcp, aws, azure) la implementación de los servicios para obtener los "temas-tests-preguntas" utiliza almacenamiento local en ficheros estáticos (json y markdown) simulando una llamada a un servicio REST. 
Es facilmente sustituible gracias a la implementacion de MVVM y del patrón service locator mediante inyeccion de dependencias (getit de flutter).

Para simplificar las actualizaciones de los tests disponibles se buscarán ficheros servidos por github dentro de este mismo repositorio (/assets/data/quizzes_es_ES.json).

Las traducciones están soportadas creando ficheros idénticos pero con el sufijo de cada traduccion. 
Por ejemplo, la seccion de "Acerca de" lee de un fichero markdown (/assets/data/about_es_ES.md) para su version española, y  (/assets/data/about_en_US.json) para su versión inglesa. 

Cada tema y sus tests, asi como sus correspondientes preguntas están tambien definidas por su idioma (/assets/data/quizzes_es_ES.json) o  (/assets/data/quizzes_en_US.json)

En cuanto a las traducciones de los textos propios de la aplicacion, están definidos en (/assets/languages/es_ES.json) o (/assets/languages/en_US.json).

Cada Test contiene una serie de preguntas y está agrupado en Temas de interés. 
 
 Un Tema tiene como propiedades, puede encontrar un ejemplo en (/assets/data/quizzes_es_ES.json):
* id: Identificador unívoco, NO debe repetirse en ningún caso.
* title: el título que aparecerá en su tarjeta
* description: aparecerá en el detalle una vez seleccionado el tema concreto
* img: imagen que lo identifique, esta imagen:
  - Si va precedida de "icon:" podrá ser cualquier icono de la [biblioteca de flutter](https://api.flutter.dev/flutter/material/Icons-class.html):
      - "icon:0xe8b5"
  - Si va precedida de "http" se buscará la URL correspondiente (recuerde que debe permitir hotlink):
      - "https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png"
* version: version del tema
* date: fecha de la ultima version
* changelog: cambios de la ultima version
* quizzes: Colección de tests relacionados con ese tema

 Un Test contiene las siguientes propiedades:
* id: Identificador unívoco, NO debe repetirse en ningún caso.
* title: Título que aparecerá en la lista de tests dentro de un tema
* description: Descripcion que se mostrará en el detalle del test una vez seleccionado
* topic: Tema al que pertenece para mostrarlo en el detalle,
* retry: Número de reintentos por pregunta, si es 0 no hay límite.
* version: Versión del test,
* results: Qué significa la puntuación obtenida, y se define mediante una fórmula y el texto a mostrar en caso de que se dé la condición;
    por ejemplo:
    ```json
    [{
        "formula": "x > 5 && x < 10",
        "result":"Adelante con el cambio de fase"
    },
    {
         "formula":"x < 5",
         "result": " Una semana de demora"
    }]
    ```
* questions: Lista de preguntas:
    * id: identifica univocamente, NO debe repetirse en ningun caso.
    * question: Pregunta
    * topic: Se puede usar para crear subtemas y así saber el contexto de la pregunta
    * video: Video de la pregunta (TBD)
    * answers: Respuestas posibles:
        * id: Identificador unívoco, NO debe repetirse en ningún caso.
        * value: Texto de la respuesta
        * detail: Detalle de la respuesta, en caso de que la elija se mostrará este texto.
        * correct: true o false según sea o no la respuesta correcta
        * type:
            * "number" mostrará un slider con un minimo y un máximo y una fórmula que afecte al resultado seleccionado, por ejemplo:
             ```json
               {
                "min": 0,
                "max": 10,
                "formula": "x*-1"
                }
             ```
         
