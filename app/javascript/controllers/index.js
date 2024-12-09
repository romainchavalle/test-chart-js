// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

const reviewDataElement = document.getElementById('linesChart');
const reviewDates = JSON.parse(reviewDataElement.dataset.dates);
const reviewRatings = JSON.parse(reviewDataElement.dataset.ratings);
const mainRating = JSON.parse(reviewDataElement.dataset.average);

const ctx = document.getElementById('linesChart').getContext('2d');
const evolutionChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: reviewDates,
        datasets: [{
            label: 'évolution de la satisfaction client',
            data: reviewRatings,
            backgroundColor: '#4284FF',
            borderWidth: 0,
            tension: 0,
            borderRadius: 12,
        }]
    },
    options: {
      animation: true,
      responsive: true,  // Rend le graphique réactif
      maintainAspectRatio: false,
        scales: {
            y: {
                beginAtZero: true,
                max: 5, // Fixe la note maximale à 5
                ticks: {
                  font: {
                      size: 14,
                  }
                },
                grid: {
                  color: '#E0E0E0',
                  lineWidth: 0.3
              },
            },
            x: {
              ticks: {
                font: {
                  weight: 'bold',
                    size: 14
                }
              },
              grid: {
                  display: false
              },
            }
        },
        plugins: {
          legend: {
              display: true,
          },
          tooltip: {
              enabled: true,
          },
          title: {  // Titre du graphique
            display: true,  // Active l'affichage du titre
            text: `Moyenne générale - ${mainRating.toFixed(1)}`,  // Texte du titre
            font: {
                size: 18,  // Taille de la police
                weight: 'bold'  // Style de la police (ici, en gras)
            },
            color: '#333'
          }}
    }
});
