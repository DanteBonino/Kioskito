/* Base de Conocimiento */
atiende(dodain, lunes, horario(9,15)).
atiende(dodain, miercoles, horario(9,15)).
atiende(dodain, viernes, horario(9,15)).
atiende(lucas, martes, horario(10,20)).
atiende(juanC, sabados, horario(18,22)).
atiende(juanC, domingos, horario(18,22)).
atiende(juanFds, jueves, horario(10,20)).
atiende(juanFdS, viernes, horario(12,20)).
atiende(leoC, lunes, horario(14,18)).
atiende(leoC, miercoles, horario(14,18)).
atiende(martu, miercoles, horario(23,24)).

/* Punto 1 */
atiende(vale, Dia, horario(HoraDeInicio, HoraDeFinal)):-
    atiende(juanC, Dia, horario(HoraDeInicio, HoraDeFinal)).
atiende(vale, Dia, horario(HoraDeInicio, HoraDeFinal)):-
    atiende(dodain, Dia, horario(HoraDeInicio, HoraDeFinal)).



/* Punto 2 */
encargado(Dia, Hora, Persona):-
    atiende(Persona, Dia, horario(HoraInicial, HoraFinal)),
    between(HoraInicial, HoraFinal, Hora).

/* Punto3 */
foreverAlone(Persona, Dia, Hora):-
    encargado(Dia, Hora, Persona),
    forall(encargado(Dia, Hora, OtraPersona), not(Persona \= OtraPersona)).

/* Punto4 */
quienPuedeEstarAtendiendo(Personas, Hora, Dia):-
    findall(Persona, encargado(Dia, Hora, Persona), Encargados),
    append(Personas, _, Encargados).

/* Punto5 */
ventas(dodain, fecha(lunes, 10, agosto), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
ventas(dodain, fecha(miercoles, 12, agosto), [bebidas(alcoholicas, 8), bebidas(noAlcoholicas,1), golosinas(10)]).
ventas(martu, fecha(miercoles, 12, agosto),[golosinas(1000), cigarrillos([chesterfield,colorado,parisiennes])]).
ventas(lucas, fecha(martes, 11, agosto), [golosinas(600)]).
ventas(lucas, fecha(martes, 18, agosto), [bebidas(noAlcoholicas,2), cigarrillos([derby])]).

vendedoraSuertuda(Persona):-
    ventas(Persona,_,_),
    forall(ventas(Persona, Fecha,_), ventaImportante(Persona, Fecha)).

ventaImportante(Persona, Fecha):-
    primerVenta(Persona, Fecha, Venta),
    esImportante(Venta).

primerVenta(Persona, Fecha, Venta):-
    ventas(Persona, Fecha, Ventas),
    nth0(0, Ventas, Venta).
    

esImportante(golosinas(Valor)):-
    Valor>100.
esImportante(cigarrillos(Marcas)):-
    length(Marcas, Cantidad),
    Cantidad>2.
esImportante(bebidas(alcoholicas, _)).
esImportante(bebidas(_, Cantidad)):-
    Cantidad>5.

    
