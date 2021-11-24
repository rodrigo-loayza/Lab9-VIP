function start(mVal, fVal, oVal, p1, p2, p3, p4, p5, c1, c2, c3, c4, c5, cOtros) {
    genero(mVal, fVal, oVal);
    pais(p1, p2, p3, p4, p5, c1, c2, c3, c4, c5, cOtros);
}

function genero(mVal, fVal, oVal) {
    const ctx = document.getElementById('myChart').getContext('2d');
    const myChart = new Chart(ctx, dataDonut(mVal, fVal, oVal));
}

function dataDonut(mVal, fVal, oVal) {

    return {
        type: 'doughnut',
        data: {
            labels: ['Masculino', 'Femenino', 'Otros'],
            datasets: [{
                data: [mVal, fVal, oVal],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 99, 132, 1)',
                    'rgba(255, 206, 86, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    }
}

function pais(p1, p2, p3, p4, p5, c1, c2, c3, c4, c5, cOtros) {
    const ctxPais = document.getElementById('myChartPais').getContext('2d');
    const myChartPais = new Chart(ctxPais, dataBar(p1, p2, p3, p4, p5, c1, c2, c3, c4, c5, cOtros))
}

function dataBar(p1, p2, p3, p4, p5, c1, c2, c3, c4, c5, cOtros) {
    return {
        type: 'bar',
        data: {
            labels: ['Otros',p1, p2, p3, p4, p5],
            datasets: [{
                label: 'Cantidad por país',
                data: [cOtros, c1, c2, c3, c4, c5],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    }
}