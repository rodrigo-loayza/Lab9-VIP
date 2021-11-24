function rdy() {
    var container = document.getElementById("cabecera-container")
    var cabeceras = container.getElementsByTagName('a')
    for (var i = 0; i < cabeceras.length; i++) {
        cabeceras[i].addEventListener('click', aClick)
    }
}


function aClick(event) {
    var aClicked = event.target
    var icon = aClicked.getElementsByTagName('i')[0]
    var iconFlag = verBotones()
    if (iconFlag !== 0) {
        var iconFlagElement = document.getElementById("cabecera-container").getElementsByTagName('a')[iconFlag].getElementsByTagName('i')[0]
        if (!icon.classList.contains('fa-chevron-circle-down')) {
            iconFlagElement.classList.remove('fa-chevron-circle-down')
            iconFlagElement.classList.toggle('fa-minus-circle')
            icon.classList.toggle('fa-chevron-circle-down')
        }
    } else {
        icon.classList.remove('fa-minus-circle')
        icon.classList.toggle('fa-chevron-circle-down')
    }
}
function verBotones() {
    var container = document.getElementById("cabecera-container")
    var cabeceras = container.getElementsByTagName('a')
    for (var i = 0; i < cabeceras.length; i++) {
        var icon = cabeceras[i].getElementsByTagName('i')[0]
        if (icon.classList.contains('fa-chevron-circle-down')) {
            return i
        }
    }
    return 0
}

rdy()

//TODOS ICON MENOS
// CLICK :
    //HAY ALGUNO CON DOWN ?
        // SI, EN i:
            // EN DONDE CLICK HAY DOWN ?
                // SI: NO HACER NADA
                // NO: BORRAR EL OTRO DOWN Y PONER MINUSE Y PONER DOWN DONDE CLICK
        // NO:
            // BORRAR MENOS Y PONER DOWN DONDE CLICK

