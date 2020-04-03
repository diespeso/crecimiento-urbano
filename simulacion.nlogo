extensions [gis]
turtles-own [poblacion_celula]

globals [
  terreno-dataset
  calle-dataset
  exclusion-dataset

  poblacion_total
]

breed [terrenos terreno]
breed [testeo test]
breed [calles calle]
breed [excls excl]

to setup
  ca
  system-dynamics-setup
  setup-testeo

  setup-patches
  setup-turtles
  ;;

  gis:load-coordinate-system (word mapa ".prj")
  set terreno-dataset gis:load-dataset "020040001A.shp"
  set calle-dataset gis:load-dataset "Calles.shp"
  set exclusion-dataset gis:load-dataset "Exclusion_lambert.shp"
  gis:set-world-envelope (gis:envelope-union-of (gis:envelope-of terreno-dataset)
                                                (gis:envelope-of calle-dataset)
                                                (gis:envelope-of exclusion-dataset))
  reset-ticks
end

to setup-testeo
  create-testeo 5000
  ask testeo [setxy random-xcor random-ycor]
end


to move-testeo
  ask testeo [
    right random 90
    forward 1]
  tick
end

to cambio
  ask testeo [
   if pcolor = black [
     set pcolor red]]
   move-testeo
end


to setup-patches
  ask patches [set pcolor green]
end

to setup-turtles
  create-turtles 10
  ask turtles [set poblacion_celula 1000] ;inicializa la población a 1000.
  ask turtles[set shape "person" setxy random-xcor random-ycor]
  ask turtles [set poblacion_total poblacion_total + poblacion_celula] ;aumenta el contador global con la población de cada célula.
end

to desplegar
  ask terrenos [ die ]
  ask patches with [pxcor >= -260 and pxcor <= -205 and pycor >= -300 and pycor <= 300] [
  set pcolor cyan
  ]

  gis:set-drawing-color white
  gis:draw terreno-dataset 1
  if label-terrenos
  [ foreach gis:feature-list-of terreno-dataset [ [vector-feature] ->
      let centroid gis:location-of gis:centroid-of vector-feature
      ; centroid will be an empty list if it lies outside the bounds
      ; of the current NetLogo world, as defined by our current GIS
      ; coordinate transformation
      if not empty? centroid
      [ create-terrenos 1
        [ set xcor item 0 centroid
          set ycor item 1 centroid
          set size 0
          ;set label gis:property-value vector-feature "CNTRY_NAME"
        ]
      ]
    ]
  ]

    ask patches with [pxcor >= -260 and pxcor <= -205 and pycor >= -300 and pycor <= 300] [
  set pcolor cyan ]
  ask patches with [pxcor >= -260 and pxcor <= -150 and pycor >= -300 and pycor <= 0] [
  set pcolor cyan ]
  ask patches with [pxcor >= -260 and pxcor <= -100 and pycor >= -300 and pycor <= -100] [
  set pcolor cyan ]
  ask patches with [pxcor >= -205 and pxcor <= -150 and pycor >= 1 and pycor <= 40] [
  set pcolor brown ]
  ask patches with [pxcor >= -150 and pxcor <= -140 and pycor >= -30 and pycor <= 1] [
  set pcolor cyan ]
  ask patches with [pxcor >= -150 and pxcor <= -140 and pycor >= 1 and pycor <= 40] [
  set pcolor brown ]
  ask patches with [pxcor >= -150 and pxcor <= -90 and pycor >= -100 and pycor <= 45] [
  set pcolor brown ]
  ask patches with [pxcor >= -100 and pxcor <= 10 and pycor >= -300 and pycor <= -50] [
  set pcolor brown ]
  ask patches with [pxcor >= -100 and pxcor <= 300 and pycor >= -300 and pycor <= -170] [
  set pcolor brown ]
  ask patches with [pxcor >= 200 and pxcor <= 300 and pycor >= -300 and pycor <= 500] [
  set pcolor brown ]
  ask patches with [pxcor >= -205 and pxcor <= 300 and pycor >= 167 and pycor <= 400] [
  set pcolor brown ];EUA
  ask patches with [pxcor >= 100 and pxcor <= 290 and pycor >= -30 and pycor <= 100] [
  set pcolor brown ]
  ask patches with [pxcor >= 115 and pxcor <= 290 and pycor >= -30 and pycor <= 300] [
  set pcolor brown ]
  ask patches with [pxcor >= 140 and pxcor <= 290 and pycor >= -130 and pycor <= -80] [
  set pcolor brown ]

  ask patches with [pxcor >= 00 and pxcor <= 10 and pycor >= 50 and pycor <= 55] [
  set pcolor red ]

  ask patches with [pxcor >= -100 and pxcor <= -77 and pycor >= 157 and pycor <= 166] [
  set pcolor blue ]
  ask patches with [pxcor >= -87 and pxcor <= -75 and pycor >= 155 and pycor <= 166] [
  set pcolor blue ]
  ask patches with [pxcor >= -74 and pxcor <= -65 and pycor >= 135 and pycor <= 146] [
  set pcolor blue ]
  ask patches with [pxcor >= -45 and pxcor <= -40 and pycor >= 125 and pycor <= 136] [
  set pcolor blue ]
  ask patches with [pxcor >= -95 and pxcor <= -90 and pycor >= 130 and pycor <= 138] [
  set pcolor blue ]
  ask patches with [pxcor >= -35 and pxcor <= -30 and pycor >= 126 and pycor <= 131] [
  set pcolor blue ]
  ask patches with [pxcor >= -120 and pxcor <= -115 and pycor >= 126 and pycor <= 131] [
  set pcolor blue ]

  ask patches with [pxcor >= -150 and pxcor <= -140 and pycor >= 94 and pycor <= 95] [
  set pcolor red ]
  ask patches with [pxcor >= -155 and pxcor <= -154 and pycor >= 94 and pycor <= 95] [
  set pcolor red ]
    ask patches with [pxcor >= -155 and pxcor <= -154 and pycor >= 94 and pycor <= 95] [
  set pcolor red ]

  ask patches with [pxcor >= -195 and pxcor <= 112 and pycor >= 120 and pycor <= 124] [
  set pcolor red ]
  ask patches with [pxcor >= -200 and pxcor <= -196 and pycor >= 2 and pycor <= 165][
  set pcolor red ]
  ask patches with [pxcor >= 20 and pxcor <= 24 and pycor >= 2 and pycor <= 120][
  set pcolor red ]
    ask patches with [pxcor >= -89 and pxcor <= 23 and pycor >= 2 and pycor <= 6] [
  set pcolor red ]
     ask patches with [pxcor >= -175 and pxcor <= -170 and pycor >= 40 and pycor <= 70] [
  set pcolor red ]
      ask patches with [pxcor >= -175 and pxcor <= -135 and pycor >= 67 and pycor <= 70] [
  set pcolor red ]
        ask patches with [pxcor >= -140 and pxcor <= -135 and pycor >= 68 and pycor <= 95] [
  set pcolor red ]
         ask patches with [pxcor >= -140 and pxcor <= -115 and pycor >= 90 and pycor <= 95] [
  set pcolor red ]
         ask patches with [pxcor >= -119 and pxcor <= -115 and pycor >= 95 and pycor <= 155] [
  set pcolor red ]

end

to desplegar_calle
   gis:set-drawing-color blue
  gis:draw calle-dataset 1
  if label-terrenos
  [ foreach gis:feature-list-of calle-dataset [ [vector-feature] ->
      let centroid gis:location-of gis:centroid-of vector-feature
      ; centroid will be an empty list if it lies outside the bounds
      ; of the current NetLogo world, as defined by our current GIS
      ; coordinate transformation
      if not empty? centroid
      [ create-terrenos 1
        [ set xcor item 0 centroid
          set ycor item 1 centroid
          set size 0
          ;set label gis:property-value vector-feature "CNTRY_NAME"
        ]
      ]
    ]
  ]
end

to desplegar_exclusion
   gis:set-drawing-color pink
  gis:draw exclusion-dataset 1
  gis:fill exclusion-dataset 1
  if label-terrenos
  [ foreach gis:feature-list-of exclusion-dataset [ [vector-feature] ->
      let centroid gis:location-of gis:centroid-of vector-feature
      ; centroid will be an empty list if it lies outside the bounds
      ; of the current NetLogo world, as defined by our current GIS
      ; coordinate transformation
      if not empty? centroid
      [ create-terrenos 1
        [ set xcor item 0 centroid
          set ycor item 1 centroid
          set size 0
          ;set label gis:property-value vector-feature "CNTRY_NAME"
        ]
      ]
    ]
  ]
end

to go
  move-testeo
  cambio

  system-dynamics-go
  tick
  wait .1
end

;; funciones para obtención de tasas relacionadas al crecimiento.
to-report tasa-natalidad [anio]
  report -0.32 * anio + 664.12
end

to-report tasa-mortalidad [anio]
  report 0.08 * anio -152.18
end

to-report tasa-inmigracion [anio]
  report 0.0000767 * anio + 0.1547
end

to-report tasa-emigracion [anio]
  report 0.0000526 * anio + 0.1062
end

@#$#@#$#@
GRAPHICS-WINDOW
497
10
1507
1021
-1
-1
2.0
1
10
1
1
1
0
1
1
1
-250
250
-250
250
0
0
1
ticks
60.0

BUTTON
19
118
150
151
NIL
setup\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
19
10
152
55
mapa
mapa
"020040001A"
0

BUTTON
18
160
150
193
display
desplegar
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
19
72
151
105
label-terrenos
label-terrenos
0
1
-1000

BUTTON
19
202
149
235
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
20
604
137
637
NIL
desplegar_calle
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
16
265
148
298
NIL
desplegar_exclusion
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
164
12
331
57
Poblacion Total
poblacion_total
17
1
11

MONITOR
172
194
290
239
Inmigrantes
inmigrantes
17
1
11

MONITOR
173
255
288
300
Migrantes
migrantes
17
1
11

MONITOR
173
319
289
364
Fenomenos Naturales
fenomenosNaturales
17
1
11

MONITOR
175
379
289
424
Fallecimientos
fallecimientos
17
1
11

TEXTBOX
321
76
460
125
Tasas 2010-2015\n1, 641, 570 (49.7%)
15
0.0
1

MONITOR
168
132
292
177
Nacimientos
nacimientos
17
1
11

SLIDER
303
253
475
286
tasa-migrantes
tasa-migrantes
0
100
27.0
1
1
NIL
HORIZONTAL

SLIDER
302
137
474
170
tasa-nacimientos
tasa-nacimientos
0.0
100
31.0
1.0
1
NIL
HORIZONTAL

SLIDER
303
197
475
230
tasa-inmigrantes
tasa-inmigrantes
0
100
26.0
1
1
NIL
HORIZONTAL

SLIDER
301
319
477
352
tasa-fenomenosNaturales
tasa-fenomenosNaturales
0
100
16.0
1
1
NIL
HORIZONTAL

SLIDER
300
381
475
414
tasa-fallecimientos
tasa-fallecimientos
0
100
25.0
1
1
NIL
HORIZONTAL

SWITCH
20
527
123
560
energia
energia
1
1
-1000

MONITOR
166
76
291
121
Crecimiento Aproximado
count testeo - 5000
17
1
11

MONITOR
137
529
194
574
green
count patches with [pcolor = green]
17
1
11

@#$#@#$#@
## WHAT IS IT?
 
Acerca del crecimiento Poblacional del Municipio de Tijuana con el programa de simulación Netlogo. En base a información de INEGI del año 2015, donde se muestra que el crecimiento de tijuana se debe principalmente a la gran migración por la gran cercanía con Estados Unidos y a que Tijuana es una ciudad muy moderna y cuenta con muchos servicios favorables para una buena vida.
 
## HOW IT WORKS
 
En base a las estadísticas del conteo poblacional del INEGI se realiza una simulación de los datos obtenidos. Los datos recopilados son analizados por el algoritmo de SLEUTH para conseguir cerca de una aproximación real a la población que tendrá en varios años.
 
## HOW TO USE IT
 
Hay tres botones: setup, display, go. Con esos botones se pueden iniciar la simulación.
 
a)	Setup: prepara las variables que sean ingresado previamente por el usuario (en los selectores, más adelante se explicará a detalle), si no ingreso datos, se ponen automáticamente los datos del 2015.
 
b)	Display: Muestra los gráficos que son necesarios para ejecutar el programa.
 
c)	Go: Empieza la ejecución del programa.
 
Recordemos que se pueden mover los selectores de las tasas de la población para generar una simulación a nuestras necesidades.
 
## THINGS TO NOTICE
 
Los gráficos fueron desarrollados en por el mismo Netlogo en base a píxeles de colores, los cuales forman todas zonas alrededor de tijuana, el mar, Estados Unidos, y municipios cercanos a Tijuana.
 
## THINGS TO TRY
 
Es posible modificar las variables que determinan el crecimiento de la población, modificando los selectores, si los selectores de la tasa de crecimiento crecen, el aumento de la población se ve gráficamente rápido..
 
## EXTENDING THE MODEL
 
Hay 5 variables en el modelo dinámico: natalidad, fallecimientos, migrantes, inmigrantes, por fenómenos naturales. Con esas cinco variables se logra crear una simulación grata de la cantidad de población en Tijuana.
 
## NETLOGO FEATURES
 
Se desarrolló en Netlogo versión 6.0, no es posible saber si en otro
 
## RELATED MODELS
 
No se usaron ningún tipo de librerías externas.
 
## CREDITS AND REFERENCES
Miguel Ángel Pasillas Luis
Ana Maria Chipres Castellanos
Esmeralda Jazmin Crespo Coronado
Ibarra Padierna Abner Jhair
Nos basamos en SLEUTH para crear esta simulación, Gracias a Bogart Yail Márquez Lobato por su apoyo en esta simulación.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
1.0
    org.nlogo.sdm.gui.AggregateDrawing 17
        org.nlogo.sdm.gui.StockFigure "attributes" "attributes" 1 "FillColor" "Color" 225 225 182 428 134 60 40
            org.nlogo.sdm.gui.WrappedStock "manchaUrbana" "manchaUrbana" 0
        org.nlogo.sdm.gui.ReservoirFigure "attributes" "attributes" 1 "FillColor" "Color" 192 192 192 144 92 30 30
        org.nlogo.sdm.gui.RateConnection 3 174 109 295 128 416 147 NULL NULL 0 0 0
            org.jhotdraw.figures.ChopEllipseConnector REF 3
            org.jhotdraw.standard.ChopBoxConnector REF 1
            org.nlogo.sdm.gui.WrappedRate "manchaUrbana + nacimientos - fallecimientos - migrantes + inmigrantes - fenomenosNaturales + poblacionTotal - restoVariable" "flujoUrbano"
                org.nlogo.sdm.gui.WrappedReservoir  REF 2 0
        org.nlogo.sdm.gui.ConverterFigure "attributes" "attributes" 1 "FillColor" "Color" 130 188 183 201 258 50 50
            org.nlogo.sdm.gui.WrappedConverter "tasa-nacimientos" "nacimientos"
        org.nlogo.sdm.gui.BindingConnection 2 233 265 295 128 NULL NULL 0 0 0
            org.jhotdraw.contrib.ChopDiamondConnector REF 9
            org.nlogo.sdm.gui.ChopRateConnector REF 4
        org.nlogo.sdm.gui.ConverterFigure "attributes" "attributes" 1 "FillColor" "Color" 130 188 183 50 212 50 50
            org.nlogo.sdm.gui.WrappedConverter "tasa-fallecimientos" "fallecimientos"
        org.nlogo.sdm.gui.BindingConnection 2 91 228 295 128 NULL NULL 0 0 0
            org.jhotdraw.contrib.ChopDiamondConnector REF 14
            org.nlogo.sdm.gui.ChopRateConnector REF 4
        org.nlogo.sdm.gui.ConverterFigure "attributes" "attributes" 1 "FillColor" "Color" 130 188 183 31 79 50 50
            org.nlogo.sdm.gui.WrappedConverter "tasa-migrantes" "migrantes"
        org.nlogo.sdm.gui.BindingConnection 2 78 106 295 128 NULL NULL 0 0 0
            org.jhotdraw.contrib.ChopDiamondConnector REF 19
            org.nlogo.sdm.gui.ChopRateConnector REF 4
        org.nlogo.sdm.gui.ConverterFigure "attributes" "attributes" 1 "FillColor" "Color" 130 188 183 173 10 50 50
            org.nlogo.sdm.gui.WrappedConverter "tasa-inmigrantes" "inmigrantes"
        org.nlogo.sdm.gui.BindingConnection 2 210 47 295 128 NULL NULL 0 0 0
            org.jhotdraw.contrib.ChopDiamondConnector REF 24
            org.nlogo.sdm.gui.ChopRateConnector REF 4
        org.nlogo.sdm.gui.ConverterFigure "attributes" "attributes" 1 "FillColor" "Color" 130 188 183 339 8 50 50
            org.nlogo.sdm.gui.WrappedConverter "tasa-fenomenosNaturales" "fenomenosNaturales"
        org.nlogo.sdm.gui.BindingConnection 2 353 47 295 128 NULL NULL 0 0 0
            org.jhotdraw.contrib.ChopDiamondConnector REF 29
            org.nlogo.sdm.gui.ChopRateConnector REF 4
        org.nlogo.sdm.gui.ConverterFigure "attributes" "attributes" 1 "FillColor" "Color" 130 188 183 345 264 50 50
            org.nlogo.sdm.gui.WrappedConverter "1641570" "poblacionTotal"
        org.nlogo.sdm.gui.ConverterFigure "attributes" "attributes" 1 "FillColor" "Color" 130 188 183 491 244 50 50
            org.nlogo.sdm.gui.WrappedConverter "5000" "restoVariable"
        org.nlogo.sdm.gui.BindingConnection 2 500 259 295 128 NULL NULL 0 0 0
            org.jhotdraw.contrib.ChopDiamondConnector REF 36
            org.nlogo.sdm.gui.ChopRateConnector REF 4
        org.nlogo.sdm.gui.BindingConnection 2 362 271 295 128 NULL NULL 0 0 0
            org.jhotdraw.contrib.ChopDiamondConnector REF 34
            org.nlogo.sdm.gui.ChopRateConnector REF 4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
