function genero(mVal, fVal, oVal) {
    const ctx = document.getElementById('myChart').getContext('2d');
    const myChart = new Chart(ctx, dataDonut(mVal, fVal, oVal));
}

// function pais(mVal, fVal, oVal) {
//     const ctxPais = document.getElementById('myChartPais').getContext('2d');
//     const myChartPais = new Chart(ctxPais, dataBar(mVal, fVal, oVal))
// }

// var jsArray = [];
// <%for(int i=0;i<arrayList.size();i++){%>
//     jsArray.push("<%= arrayList.get(i)%>");
//     <%}%>

function dataDonut(mVal, fVal, oVal) {

    return {
        type: 'doughnut',
        data: {
            labels: ['Masculino', 'Femenino', 'Otros'],
            datasets: [{
                label: 'Porcentaje de Género',
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

function dataBar() {
    return {
        type: 'bar',
        data: {
            labels: ['Red', 'Blue', 'Yellow'],
            datasets: [{
                label: '# of Votes',
                data: [12, 19, 3],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)'
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