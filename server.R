# server.R
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

shinyServer(function(input, output) {

    observeEvent(input$imprimir,{
         inicial<-input$inicial
         final<-input$final
         numero.etiquetas<-length(c(inicial:final))
         if (numero.etiquetas>10){
             showModal(modalDialog(
                 title='Impresión de etiquetas',
                 paste('¿Seguro que quieres imprimir',numero.etiquetas,'etiquetas?'),
                 footer = tagList(
                     modalButton("Cancelar"),
                     actionButton("ok", "OK"))
              ))
          
          
        } else { 
            imprime.etiquetas()
        }
    })
  
    observeEvent(input$ok,{
        imprime.etiquetas()
    })
    # Proveemos de datos a la vista previa
    datos<-reactive({
        puerto<-input$linea1
        buque<-input$linea2
        fecha<-input$linea3
        lance<-input$linea4
        especie<-input$linea5
        data.frame(puerto,buque,fecha,lance,especie)
    })

    # Vista previa de la etiqueta
    output$previsualiza<-renderPlot({
        dat<-datos() 
        plot(NULL,xlim=c(0,300),ylim=c(0,100),axes=FALSE,ann=FALSE)
  
        if (dat$fecha!='' & dat$lance!=''){
            linea3<-paste(dat$fecha,'- P.',dat$lance)
        } else if (dat$fecha=='' & dat$lance!=''){
            linea3<-paste('Pesca',dat$lance)
        } else if (dat$fecha!='' & dat$lance==''){
          linea3<-dat$fecha
        } else {
          linea3<-''
        }
  
        text(125,90,dat$puerto,cex=2.9)
        text(125,65,dat$buque,cex=2.9)
        text(125,40,linea3,cex=2.9)
        text(125,15,dat$especie,cex=2.9)
        text(275,50,'1',cex=8)
        box("plot")
    })
  
    imprime.etiquetas<-function(){
        # Aquí va la IP de la impresora
        impresora<-socketConnection(host='192.168.2.81',port=9100)
        puerto<-input$linea1
        buque<-input$linea2
        fecha<-input$linea3
        lance<-input$linea4
        especie<-input$linea5
        inicial<-input$inicial
        final<-input$final
      
        if (fecha!='' & lance!=''){
            linea3<-paste(fecha,'- P.',lance)
        } else if (fecha=='' & lance!=''){
            linea3<-paste('Pesca',lance)
        } else if (fecha!='' & lance==''){
            linea3<-fecha
        } else {
            linea3<-''
        }
        # Generación del ZPL2 para la impresora
        for (etiqueta in c(final:inicial)){
            texto.etiqueta<-paste("^XA
                   ^CI28
                   ^PW305
                   ^FO5,12
                   ^FB280,4,-1,C,0
                   ^AQ
                   ^FD",puerto,"\\&",buque,"\\&",linea3,"\\&",especie,"^FS
                   ^FO70,27
                   ^FB400,1,0,C,0^AU,50
                   ^FD",otolito,"^FS
                   ^XZ\n", sep='')
            writeLines(texto.etiqueta,impresora)
        }
        close(impresora)
        removeModal()
    }
})
