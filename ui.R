# ui.R
# This file is part of simplEtik.

# simplEtik, a simple Shiny app for labelling with a Zebra GTK420t 
# label printer (or any other ZPL2 compatible printer) on 1.5x1" labels
# Copyright (c) 2020 Jorge Tornero (@imasdemase), Spanish Institute of Oceanography

# simplEtik is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# simplEtik is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with simpleEtik.  If not, see <https://www.gnu.org/licenses/>.

library(shiny)

shinyUI(fluidPage(
  
    titlePanel("Impresión etiquetas"),
    sidebarLayout(
        sidebarPanel(
            textInput('linea1','Campaña/Puerto',''),
            textInput('linea2','Buque',''),
            textInput('linea3','Fecha',''),
            textInput('linea4','Pesca/Lance',''),
            textInput('linea5','Especie',''),
            numericInput('inicial','Otolito inicial',1,1000,1),
            numericInput('final','Otolito final',1,1000,1),
            actionButton('imprimir','Imprimir')
        ),
    mainPanel(
       plotOutput("previsualiza")
    )
    )
))
