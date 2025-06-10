import { Controller } from '@hotwired/stimulus'
import { Chart, DoughnutController, ArcElement, Tooltip } from 'chart.js'

Chart.register(DoughnutController, ArcElement, Tooltip)

// Connects to data-controller="charts--spending-breakdown"
export default class extends Controller {
  static values = {
    data: Array
  }

  connect () {
    this.chart = new Chart(this.element.getContext('2d'), {
      type: 'doughnut',
      data: {
        labels: this.dataValue.map((i) => i.label),
        datasets: [
          {
            data: this.dataValue.map((i) => i.value),
            backgroundColor: this.dataValue.map((i) => i.color),
            formatted: this.dataValue.map((i) => i.formatted)
          }
        ]
      },
      options: {
        plugins: {
          tooltip: {
            callbacks: {
              label: (context) => context.dataset.formatted[context.dataIndex]
            }
          }
        }
      }
    })
  }

  disconnect () {
    this.chart.destroy()
    this.chart = undefined
  }
}
