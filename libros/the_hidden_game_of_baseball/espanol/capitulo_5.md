# Capítulo 5
Traducido por Luis Amparou( @luisamparou [Twitter](https://twitter.com/luisamparou) y  [Github](https://github.com/luisamparou) )

Se espera que cada equipo gane más partidos en la casa que en la ruta, al punto de que si solo ganan la mitad de sus partidos en la ruta se considere que tienen una chance de alzarse con el banderín.

El equipo dueño de casa debe sacar más ventaja a las peculiaridades de su terreno (sea un estadio para bateadores o para lanzadores) que el equipo que les visite.

¿Por qué a un equipo, ya sea fuerte o débil, le va mejor en su casa en relación a cómo juega en la ruta? Los jugadores se benefician de estar por muchos días consecutivos en casa (digamos que de ocho a trece partidos): se quedan en predios conocidos, duermen más o menos en horario regular, juegan frente a fanáticos que les apoyan y se benefician de las condiciones físicas del estadio que, para empezar, de alguna u otra manera, jugaron un rol en su adquisición por el equipo. Es bastante difícil para los fanáticos ponerse en los zapatos del jugador y comprender lo complicado que es jugar en el día que se viaja y/o de ajustarse al desfase horario y a las “amenidades” de los hoteles.

En promedio los jugadores batean y lanzan a una tasa 10% mayor en casa. Es decir, el porcentaje de embasado y el porcentaje de slugging tienden a ser 5% mayor (cuando se combinan en el OPS, un 10%); el AVG será también un 5% mayor. Las mediciones lineales, debido a que se denominan en carreras, serán 10% mayor en la casa; mientras que la ERA, por la misma razón, será un 10% menor. Estas afirmaciones son reales en promedio, pero, si revisamos los casos individuales, los factores de parque podrían variar considerablemente.

Las estadísticas de bateo reflejan no sólo cómo los jugadores jugaron, también dónde jugaron. Esto último tiene un efecto mayor en los jugadores bendecidos de tener la mitad de sus partidos en Shibe Park, Fenway Park o en el Wrigley Field; y también en esos “malditos” por haber sido habitantes de Yankee Stadium, San Diego Stadium o el Astrodome.

Si quisiéramos eliminar lo trampolín o piedra en el zapato que puede ser un estadio y concentrarnos en las habilidades individuales de los jugadores, debemos crear un “balanceador estadístico” que disminuya los numeritos que los jugadores consigan en estadios como el Fenway, y sobrevalúen los conseguidos en lugares como San Diego.

Los estadios difieren de tantas formas que podría ser difícil imaginar como sus diferencias podrían ser cuantificadas. La manera más clara en la que difieren es en sus dimensiones: desde el home plate hasta las paredes de los jardines, y desde las bases hasta las gradas. Los estadios más antiguos (Fenway Park, Wrigley Field, Tiger Stadium) tienden a favorecer a los bateadores de ambas maneras debido a que tienen muy cerca las cercas y poco espacio para intentar atrapar un elevado de foul.
Podría ocurrir que dos estadios tengan prácticamente las mismas dimensiones (como ocurre con el Three Rivers Stadium de Pittsburgh y el Fulton County Stadium de Atlanta) y aun así impacten de manera distinta a los jugadores debido al clima (la pelota viaja más en climas más calientes), elevación (la pelota viaja más sobre el nivel del mar) y superficie de juego (viaja más rápido y mejor en césped artificial). Otro factor es cómo los jugadores creen que ven la bola. El Shea Stadium es causa de quejas.

Aun tal vez más importante que las características objetivas de los estadios, es la actitud de los jugadores: la manera en que el estadio cambia cómo ellos creen que el juego debe ser jugado para garantizarles la victoria.

Un equipo exitoso es aquel que sabe jugar sus partidos de la casa (esos para los que el equipo fue construido) y que también es lo suficientemente flexible para adaptarse a la ruta.

En vez de intentar asignar un valor numérico a cada una de las seis (o más) variables que pueden influir al establecer un estimador del impacto que tiene el estadio propio, Pete Palmer se fijó en la única medición en la que todas estas variables se reflejan (las carreras). Después de todo, ¿para qué vamos a asignar un valor a las dimensiones del parque, otro al clima, etcétera, si no es para identificar su impacto en las anotaciones? Si un estadio es “para bateadores” es porque más carreras serán anotadas ahí que en uno percibido como “neutral”, así como de un estadio “para lanzadores” se espera que disminuya la producción de carreras.

Para medir el impacto del estadio, Pete no solo tiene en cuenta las carreras hechas por el equipo de casa, las cuales pudieron haber sido producidas tomando ventaja de las peculiaridades del estadio, sino también las anotadas por los equipos visitantes. Al tomar el total de las carreras producidas por todos los equipos en un año y dividiendo ese número entre las carreras permitidas por los equipos en la ruta, se tiene el primer paso para determinar el Park Factor, o Factor Parque que podría ser aplicado a bateadores y lanzadores de un equipo (también podría aplicarse a ladrones de base, etc).

Para la mayoría de nosotros, sin embargo, será suficiente entender que el Factor Parque consiste en la proporción casa-ruta de carreras permitidas del equipo, comparándola con la proporción casa-ruta de carreras permitidas de la liga, para así saber si está por encima del promedio. El batter adjustment factor (factor de ajuste para el bateador, en español), o Batter Park Factor (BPF) (Factor Parque del Bateador, en español) consiste en:

* El Park Factor.
* Un ajuste debido a que el bateador no tiene que enfrentar a los lanzadores que pertenecen a su equipo.

El pitcher adjustment factor (factor de ajuste para el lanzador, en español), o Pitcher Park Factor (PPF) (Factor Parque del Lanzador, en español), igualmente, consiste en el Factor Parque y un ajuste debido a que el lanzador no tiene que enfrentar a los bateadores que son sus compañeros de equipo. El BPF y el PPF se expresan en relación al Factor Parque de su estadio, que es, matemáticamente, 1.00. Un estadio en el que se anote 5% más que un estadio promedio tendrá 1.05 de BPF, mientras que el PPF para el mismo estadio podría ser 1.04 o 1.00 debido a que el ajuste se hace de maneras distintas.

Un estadio que tenga características “extremas” (es decir, que favorezca a lanzadores o bateadores, a derechos o a zurdos) puede ser un problema. En Fenway, los equipos visitantes casi nunca colocan a un lanzador zurdo a abrir partidos, debido a que los Red Sox históricamente llenan su alineación de derechos que puedan conectar la bola 350 pies a su banda sobre el Monstruo Verde.

Las características del estadio o casa juegan un papel en la mente de la gerencia en el momento de sopesar un cambio de jugador. Incluso puede estar en la mente de los mánagers.

El Park Factor ofrece una verdad sugestiva que es esencialmente y lógicamente creíble, pero que no es una “verdad” estadísticamente (de todos modos, las estadísticas nunca comprueban, son estimaciones de la verdad).
