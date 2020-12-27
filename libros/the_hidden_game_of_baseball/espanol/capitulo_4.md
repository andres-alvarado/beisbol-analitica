# Capítulo 4
Traducido por Miguel Corona ( @bretanic en [Twitter](https://twitter.com/bretanic) y [Github](https://github.com/bretanic) )

## La Ponderación Lineal

La Ponderación Lineal asigna un valor de carrera a los diferentes eventos de Ofensiva. En esencia, la base es la misma para la fórmula Rickey y la mayoría de las nuevas estadísticas desde entonces: que las victorias y derrotas es de lo que se trata el juego; que las victorias y carreras en turno son proporcionales a los eventos que las generan.

Con la ponderación lineal, estos eventos no se expresan en los índices más comunes y ambiguos (desde hits a turnos al bat, desde victorias a decisiones, etc.) sino en carreras contribuidas (bateo, robo) o evitadas (Pitcheo, fildeo). Los factores para normalizar (el promedio de la liga) incluidos en las fórmulas para todos estos índices, excepto el robo, en el que el promedio de la liga no es una fuerza definitoria, nos permiten computar el número de carreras provistas el año anterior que son extra a las que un hitter promedio pudo haber producido en un número equivalente de apariciones a la caja de bateo. Y, al hacer ajustes considerando la influencia de la localía, la comparación de ponderaciones lineales puede extenderse a cuántas carreras se acreditan, más allá de las que un jugador promedio pudo haber producido en el mismo número de turnos al bat haya tenido en la mitad de sus juegos, en un estadio específico.
Habiendo determinado el número de carreras necesarias para transformar una derrota en una victoria en las estadísticas finales, podemos convertir el record de ponderaciones lineales de un jugador, expresado en carreras, al número de victorias arriba del promedio que contribuyó el solo. Por último, al revisar las contribuciones de todos los bateadores, pitchers, jardineros y roba bases del equipo, podemos establecer un cálculo sólido de las fortalezas y debilidades de ese equipo para la siguiente temporada incluso si, por ejemplo, pareciera ser un fuerte contendiente sin cambios en su plantilla o si, por el contrario tuviera que importar nuevos jugadores para mantenerse.
Debemos reconocer que una parte sustancial del valor de carrera de cualquier jugada que no sea out es que permite traer otro jugador a la caja de bateo. Este bateador adicional tiene también una oportunidad de llegar a una base y así traer a otro hombre a la caja, y así sucesivamente. El potencial indirecto de carrera por parte de estos bateadores no puede ser ignorado.

Los valores de las ponderaciones lineales son determinados en términos del número de carreras y carreras impulsadas que produce cada evento. Los valores de carrera en la ponderación lineal identifican la contribución real de los bateadores.

Las bases robadas y los robos evitados no son parte de la fórmula de ponderación lineal debido a su naturaleza electiva, a su dependencia de la situación: Estos intentos suelen ocurrir con mayor frecuencia en juegos reñidos, en los que pueden ser más valiosos que si se distribuyeran aleatoriamente, de la misma manera que lo hacen los sencillos o los home runs.

## La Fórmula

Así como estos valores de carrera cambian marginalmente de acuerdo a las condiciones cambiantes de juego, también difieren ligeramente de acuerdo al orden al bat (un home run no vale tanto si lo hace el primero al bat como si lo hace el quinto; una base por bolas vale más para el segundo al bat que para el octavo); sin embargo, estas diferencias ya han sido consideradas.

Los eventos no incluidos en la fórmula que se pudieran haber esperado son los sacrificios, hits de sacrificio, doble plays y bases por errores. El sacrificio tiene valores de cancelación. Se cambia un out por un avance de base que, casi siempre, deja al equipo en una situación de potencial de carrera peor que antes del sacrificio (más sobre esto en el capítulo 8).

El tiro de sacrificio tiene un valor de carrera dudoso porque depende enteramente de una situación que no está bajo el control del bateador. Mientras que un sencillo o una base por bolas siempre tiene un valor de carrera potencial, un batazo largo no lo tiene, a menos que se tenga un hombre en tercera base (Se puede cuestionar si esto se obtiene por accidente o se planeó, pero es como preguntar si el ser golpeado por una bola es a propósito o no).
Por último, el doble play es hasta cierto punto una función del lugar de uno en el orden al bat más que de la falta de velocidad o de falta de agarre, por lo que no encuentra lugar en una fórmula que sea aplicable a todos los bateadores.

La fórmula de ponderación lineal puede simplificarse eliminando los componentes de robos, robos fallados y outs en base.La fórmula de ponderación lineal para bateadores puede ser larga, aún en su forma simplificada, pero solo requiere suma, resta y multiplicación, por lo cual es tan simple como el porcentaje de bateo, además de que se revisa y profundiza sobre las ponderaciones incorrectas de este último (1, 2, 3 y 4).

Cada evento tiene un valor y una frecuencia, al igual que en el porcentaje de bateo aunque, a diferencia de cualquier otra estadística de bateo antes vista, los outs se toman como actos de ofensiva con valores de carrera propios (aunque negativos). Una verdad tan obvia que se pasó por alto, de la misma manera que el potencial de carrera para un equipo en cualquier media entrada es incrementado si un hombre llega a base o es reducida si se retira a algún otro; no solo falló en cambiar la situación en las bases, sino que también ha privado a su equipo de los servicios de alguien más en el orden que hubiera podido presentarse en esta media entrada, ya fuera con otros en base y/o con carreras ya anotadas.

Lo que hace la ponderación lineal es tomar cada evento ofensivo y tratarlo en términos de su impacto sobre el equipo, de modo que el hombre no se beneficie en su récord individual. La relación del desempeño individual y el juego de equipo se menciona poco o nada en las estadísticas convencionales del baseball, pero es muy clara para la ponderación lineal: la progresión lineal, la suma de los varios eventos ofensivos, cuando se ponderan con los valores de carrera predichos correctamente, darán el total de carreras con las que contribuye el bateador.

La ponderación lineal tiene una “estadística sombra”: OPS (Lllegadas a base más bateo). Aunque OPS no está expresado en carreras y eso hace que no siga la misma filosofía de la ponderación lineal, consiste de 2 medidas, Porcentaje de llegadas a base y porcentaje de bateo que son, en cierta medida, mejores que el promedio de bateo. El porcentaje de llegadas a base considera las bases por bola y los golpes por lanzamiento pero con el inconveniente de que trata a todas las bases por igual. El porcentaje de bateo pondera los hits, de acuerdo a las bases conseguidas, pero no toma en cuenta ninguna base ganada sin un hit. Estos dos porcentajes, en conjunto, hacen un indicador muy sólido. Las debilidades de uno son casi completamente compensadas por las fortalezas del otro.

Sin embargo, como un promedio o tasa, el OPS mide el éxito de bateo (eficiencia), mientras que la ponderación lineal mide la cantidad de éxito. Claramente, la longevidad o la cantidad de producción no son menos importantes que la tasa de producción. La ponderación lineal tiene incluida un factor normalizante.

## Carreras y Victorias

Debido a que el OPS no está expresado en carreras, es menos versátil que la ponderación lineal. Así como las carreras son proporcionales a los eventos que las generan, estas son proporcionales a las victorias y derrotas. Bill James, en el Abstracto de Baseball, desarrolló el porcentaje de victorias como R^2 / (R^2 / RA^2).

¿Qué tienen que ver las victorias con la ponderación lineal? Teniendo en mente que la ponderación lineal está expresada en carreras, la conversión de la ponderación lineal de un bateador a sus victorias es sencilla.

Al igual que la ponderación lineal puede mostrar que un bateador sobresaliente haya contribuido más allá de las carreras y victorias promedio de su equipo, también puede mostrar cómo los bateadores abajo del promedio tienen marcas negativas, que se obtienen cuando la pérdida de carreras por medio de outs excede las carreras ganadas por medio de las llegadas a base.

## Carreras con Bases Robadas
Se requiere de un desempeño fabuloso en robos para producir algo como una victoria extra para el equipo. El hecho es que, aunque la ganancia de una base robada es muy visible (una base extra que puede ser seguida por un hit que de otro modo no hubiera producido una carrera), el costo de un robo fallado es completamente invisible, o sujeto a conjeturas, si se recurre a la ayuda de las estadísticas.

Lo que indica la ponderación lineal es que, en balance, y no en una base de casos específicos, la base robada es, como mucho, un método dudoso para incrementar la producción de carreras de un equipo.

## Ponderación Lineal en la Práctica
Teniendo fórmulas para pitcheo, atrapadas, avances a base y bateo, podemos evaluar la contribución al marcador de carreras de cada individuo que alguna vez haya jugado el juego y, en consecuencia, el número de victorias a las que ha contribuido en cualquier temporada o a lo largo de su carrera.
