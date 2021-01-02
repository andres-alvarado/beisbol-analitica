
# Chapter 8 - El libro ... y la Computadora
Traducido por Carlos Muñoz( @carlos96martinez en [Twitter](https://twitter.com/carlos96martinez) y [Github](https://github.com/carlos96martinez) )


El béisbol, como el póquer, es un juego en el que las situaciones varían dentro de un rango definido y, por lo tanto, pueden modelarse matemáticamente; dentro de tal modelo, se calcula la probabilidad de que una táctica en particular tenga éxito. Esto está atestiguado por la tendencia tradicional de los gerentes de "jugar los porcentajes" no solo porque en el largo plazo el porcentaje de béisbol es ganar juegos, ganar béisbol, sino también porque los pilotos, al recurrir a una autoridad superior en forma de "El Librito", desvían mucho de cuestionar lo que va en contra de la longevidad de la carrera. Pero, ¿cómo pueden pretender jugar los porcentajes si no saben cuáles son?

Como dijo Pete Palmer: "Todos estos gerentes hablan de jugar con “El Librito”, pero ni siquiera han leído tal “Librito”. No saben qué contiene. Todos usan las mismas viejas estrategias, muchas de las cuales son ridículas. Cada análisis matemático que he visto muestra que la base por bolas intencional es casi siempre una mala jugada, las bases robadas son solo marginalmente útiles y el toque de sacrificio es un vestigio relativamente inútil de la era de la bola muerta cuando no solían traer a un bateador emergente por el lanzador.

Por supuesto, cuando la gente del béisbol habla de “El Librito”, no quiere decir nada que esté en lo desconocido. Se refieren a la sabiduría popular que se ha acumulado a través de prueba y error. La mayoría de los elementos importantes de la estrategia se remontan a antes del cambio de siglo (el robo, el sacrificio, el hit y la carrera, la clásica "jugada porcentual" de traer a un bateador zurdo contra un lanzador derecho).

Entonces, como ahora, el juego porcentual consistía en nada más que lograr la mayor ganancia posible en la anotación, o prevención de carrera asumiendo el menor riesgo posible. A medida que aumenta la perdida, también debe aumentar la recompensa; de lo contrario, se dice que los porcentajes actúan en tu contra.

Las mismas maniobras que Ned Hanlon, Connie Mack y John McGraw usaron con tanto éxito en la era de la bola muerta han seguido siendo artículos de fé para los entrenadores durante el explosivo período de bateo, y que continúan siendo veneradas hoy.
La vieja defensa de las prácticas pasadas de moda, "Siempre lo hemos hecho de esa manera") revela la preferencia conservadora de lidiar con lo conocido en lugar de lo desconocido. El viejo código sobrevive incluso cuando las circunstancias que lo llevaron a existir desaparecieron hace mucho tiempo. Pero lo que sucedió con esta idea, nacida de una época y unas condiciones particulares, fue que se afianzó y creció, extendiéndose a otras épocas, y otras condiciones que no habrían sido fecundas para su invención.

La computadora nos permite analizar grandes masas de datos, establecer valores de ejecución para situaciones y eventos, y evaluar las opciones disponibles para un entrenador o jugador.

Como se llegó a discutir anteriormente, las estadísticas de los individuos reflejan sus carreras contribuidas o guardadas, por lo que podemos examinar los elementos de la estrategia para reflejar sus carreras potenciales ganadas en caso de éxito o pérdidas en caso de falla. Necesitaremos saber: (a) la situación potencial de anotación de carrera que existe antes de que se emplee una táctica contemplada (b) el potencial de carrera que resultaría si el movimiento tuviera éxito; y (c) el potencial de ejecución restante si falla. Armado con esta información, un gerente o fanático puede sopesar la posible ganancia contra la posible pérdida, y podría determinar objetivamente si la táctica es de hecho una jugada porcentual.

Para calcular el valor de ejecución esperado de cada estrategia posible, Pete Palmer primero calculó el potencial de ejecución para la situación dada independientemente de la anotación, en segundo lugar, la probabilidad de ganar el juego.
Estos dos cálculos son diferentes porque una estrategia puede tener muchas más consecuencias en la séptima, octava o novena entrada que al principio; el toque de sacrificio o la base intencional en bolas no pueden distribuirse al azar durante el transcurso de un juego.

Palmer también calculó el número de carreras potenciales para cada una de las veinticuatro situaciones de “out”. La siguiente tabla muestra el potencial de ejecución calculado por Palmer para el período 1961-1977.

|         |       |  Outs |      |
|:-------:|:-----:|:-----:|:----:|
| Runners |   0   |   1   |   2  |
|   ---   |  .454 |  .249 | .095 |
|   1--   |  .783 |  .478 | .209 |
|   -2-   | 1.068 |  .699 | .348 |
|   --3   | 1.277 |  .897 | .382 |
|   12-   | 1.380 |  .888 | .457 |
|   1-3   | 1.639 | 1.088 | .494 |
|   2-3   | 1.946 | 1.371 | .661 |
|   123   | 2.254 | 1.546 | .798 |

Al comienzo de la mitad de la entrada, sin nadie “out”, ni corredores en base, el potencial de anotar carreras era de .454. En términos generales, durante la última década, los equipos han tendido a anotar alrededor de 4.5 carreras, lo que se reduce a aproximadamente media carrera por entrada.

Entonces, ¿por qué la cifra de la tabla es .454 y no .500? Primero, porque un equipo local victorioso no batea en nueve entradas, sino en ocho (excepto cuando la victoria se obtiene en la novena); segundo, porque durante la mayor parte de la década de 1960 dominó el pitcheo, de modo que el equipo promedio anotó algo menos de 4.5 carreras. Si hay un hombre en tercera y un out, el equipo debe anotar, en promedio .897 carreras.

Qué significa eso? ¿Ese 89,7 por ciento de las veces, el hombre en tercera debería anotar? No, no exactamente: significa que el potencial de anotación de 2 carreras es de .897 en función de que haya un hombre en tercera y al menos dos bateadores adicionales en la mitad de la entrada, salvo una doble jugada, “pick-off” o intento de robo fallido. Sumar el potencial de carrera del hombre en tercera más el de los dos bateadores adicionales, que pueden embasarse ellos mismos, proporciona el .897. En el caso del primer bateador, digamos que nadie estaba en base, entonces el potencial de carrera para el equipo sería .249. Por lo tanto, vemos que la situación a la que se enfrenta este bateador .249 del valor de carrera del equipo es atribuible a la posibilidad del bateador de llegar a la base, lo que no solo trae al siguiente bateador sino quizás a varios más, dependiendo de los resultados. Esto significa que del valor de carrera inherente a la situación "hombre en tercera, un out" (es decir .897), .249 reside en el (los) bateador (es) y .648 en el corredor.

Dicho esto: ¿Cuál es el punto de equilibrio de una estrategia? ¿Dónde se cruzan el riesgo y la recompensa, y cuál es el "porcentaje de juego"? Para encontrar el punto de equilibrio, debemos identificar el punto en el que el valor de ejecución que existe antes de que la estrategia empleada sea igual al valor de ejecución después de que se haya empleado la estrategia. Este puede ser como se expresa como una ecuación:

`Pb x Vs + (1 - Pb) x Vf = Vp`

`Pb` es la probabilidad de alcanzar el punto de equilibrio con una estrategia determinada. `Vs` es el valor de un éxito, mientras que `Vf` es el valor de un fracaso. `Vp` representa el valor presente (es decir, antes de que se haya puesto en marcha la estrategia). Reorganizando los términos para dejar el punto de equilibrio a un lado, ya que esto es lo que estamos tratando de encontrar, obtenemos:

`Pb = (Vp - Vf) / (Vs - Vt)`

## El sacrificio

El valor de ejecución potencial siempre es menor después de un sacrificio exitoso. Con la introducción de la bola viva, el toque de sacrificio debería haber desaparecido, excepto quizás en situaciones en las que se permite al lanzador llegar al plato en las últimas entradas con un hombre en primera. El toque de bola de cualquier otro hombre en el órden de bateo debería haberse convertido en un modo de estrategia tan poco frecuente como el “squeeze play”.

El sacrificio se ha utilizado de manera promiscua porque el riesgo asociado no ha sido tan obvio (la afirmación también es válida para el intento de robo). No puedes entregar, regalar un “out”. El toque "exitoso" reduce una positiva ofensiva de tu equipo en media entrada.


## El Robo

La base robada, como se indica en el capítulo sobre el sistema de pesos lineales, es una jugada sobrevalorada, en la que incluso los mejores robadores de bases contribuyen con algunas carreras o victorias adicionales a sus equipos. La razón de esto es que el punto de equilibrio es muy alto, aproximadamente dos robos en tres intentos. La cifra precisa se puede obtener de la Tabla de expectativa de ejecución (Run Expectancy Table) y la ecuación del punto de equilibrio. Un corredor en primera sin outs vale .478 Un robo de segunda lo aumenta a.699; una falla ofensiva deja a nadie en la base con dos “outs”, por valor de .095.

`Pb = (.478 -.095) / (.699 -.095) = .634`


¿Qué hay de robar otras bases? Su equipo sufrirá mucho más por no haber logrado un robo de base, porque ya tendría muchas posibilidades de anotar, simplemente por haber un hombre en la segunda base.

Hasta robar el “home plate” es una buena jugada, un porcentaje mucho mejor que robar tercera base debido al enorme potencial en comparación con el riesgo, necesita un 35% de probabilidad de éxito para lograr dicha jugada:

`Pb = (.382 -.000) / (1.095 –.000) = .349`

## La base intencional por bolas

Y así como Palmer mostró que el toque de sacrificio nunca eleva el valor de carrera del equipo, también muestra que la base intencional por bolas nunca reduce el número esperado de carreras anotadas. Sin embargo, hay casos en los que un IBB (Intentional Base on Balls) reducirá el valor de carrera del equipo a la ofensiva.

Debido a que el lanzador tiene permitido batear en la Liga Nacional, con frecuencia se emite una base intencional por bolas cuando hay dos “outs”, uno o dos hombres en juego, una base abierta y el bateador que beta de octavo en la alineación. Este es el uso clásico del IBB (no para preparar una jugada forzada, sino para trabajar con un bateador de menor habilidad). Este movimiento reduce ligeramente la probabilidad de que una carrera anote en esa mitad de la entrada, pero la reducción está más que compensada por la mayor probabilidad de que el equipo anote en su siguiente turno al bate). Esto se debe a que la siguiente entrada, en cambio de comenzar con el lanzador como bateador, se abre con el primer bate. Si el lanzador es retirado, la defensa puede haber salvado una carrera o dos, pero la ofensiva comienza la siguiente entrada en una situación más beneficiosa.

## El orden de bateo

En su porcentaje de béisbol de 1964, Earnshaw Cook se dió cuenta correctamente de que en el transcurso de una temporada, el primer bateador tenía más turnos al bate que los otros ocho; el segundo bateador tenía más de los siete hombres debajo de él; y así. Entonces, razonó, ¿por qué no dar a los mejores bateadores del equipo el número máximo de turnos al bate para que puedan lograr más hits y así producir más carreras?


## El Sistema

La computadora permite la grabación y el análisis jugada por jugada (de hecho tono por tono), lo que, entre otras cosas, nos permitiría mejorar las métricas avanzadas.

Al almacenar datos jugada por jugada para análisis futuros, la computadora permite a los gerentes realizar un seguimiento de cómo les va a los bateadores individuales contra los lanzadores individuales y viceversa, o cómo se desempeñan los jugadores en un sinnúmero de condiciones variables (es decir, día contra noche, césped artificial contra hierba, bola curva contra bola rápida, etc.).

Con la entrada adecuada, una computadora puede decirle con qué frecuencia los intentos de robo tienen éxito contra un receptor en particular o, lo que es más interesante, un lanzador. O puede revelar cómo le ha ido a un bateador contra un lanzador en particular.

Si el gerente general de los Bravos quisiera juzgar qué le habría pasado a su equipo en 1983 si hubiera elegido a Rick Honeycutt, o Sixto Lezcano en lugar de dejarlos ir a otros clubes, un modelo de computadora podría decirle. Una computadora puede ejecutar una temporada completa con una nueva variable en unos pocos minutos, por lo que un gerente general puede construir un escenario para un posible intercambio que predecirá la diferencia que harán los nuevos jugadores en el récord de ganados y perdidos del equipo. Y eso le dirá al G. M. a que jugador recurrir dentro de su equipo, o agencia libre, etc.

La computadora puede ayudar a un equipo a adaptarse a las características de un estadio de béisbol. Puede ayudar a un gerente a decidir muchas variantes cuando juega en Toronto o Seattle, o restringirlos en Nueva York o Detroit.

Aquellos gerentes que persisten en la vieja sabiduría conocida como “El Librito” no están jugando con los porcentajes, están jugando con dinamita. Sin que ellos lo sepan, no son jugadores porcentuales, sino jugadores de corazonadas (sin importar que sus corazonadas estén respaldadas por la tradición). A la larga, los jugadores de corazonada fracasan.

Al analizar eventos de todo tipo en términos de su potencial de anotación y probabilidad de ganar, con la ayuda de la computadora, los porcentajes no necesitan ser un tema de debate. Lo que se dice, o lee en “El Librito” ya no es una forma de hablar o un producto de la imaginación, sino un libro real.
