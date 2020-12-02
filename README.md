# simplEtik
simpleEtik is a simple Shiny app for label printing.

## Installation
Just copy the ui.R and server.R files in a folder inside your Shiny server root or, alternatively, edit/run it with RStudio.
You must set your printer's IP properly in the script (currently at server.R, line 82) for simplEtik to work,

## Usage
simpleEtik has been programmed to print on 1.5" x 0.5" labels on a ZPL2-compatible printer like Zebra GK-420t with ethernet connection. This is ideal for labelling vials, otolith slides, etc.

Just fill the fields of the form and click on 'Imprimir'. Date/Haul fields behave a little different because they will be joined in a single line if both are filled.
Take into account that there is no much room for the texts (about 18 characters for this label).

Please notice that preview of the label is not accurate - Just for checking that the texts you will print are correct.
