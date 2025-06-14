import { Controller } from '@hotwired/stimulus'
import SimpleMaskMoney from 'simple-mask-money'

// Connects to data-controller="money-field"
export default class extends Controller {
  #remove = () => {}

  static values = {
    allowNegative: Boolean,
    symbol: String,
    symbolFirst: Boolean,
    decimalMark: String,
    thousandsSeparator: String,
    exponent: Number
  }

  connect () {
    this.#setupInput()
    this.#setupUnmaskOnSubmit()
  }

  disconnect () {
    this.#remove()
  }

  #setupInput () {
    this.#remove = SimpleMaskMoney.setMask(this.element, {
      allowNegative: this.allowNegativeValue,
      decimalSeparator: this.decimalMarkValue,
      thousandsSeparator: this.thousandsSeparatorValue,
      fractionDigits: this.exponentValue,
      fixed: true,
      cursor: 'end',
      ...this.#symbolOptions()
    })
  }

  #setupUnmaskOnSubmit () {
    this.element.form.addEventListener('submit', () => {
      const maskedValue = this.element.value
      this.element.value = maskedValue.replace(/[^0-9-]/g, '') // keep numeric characters
      setTimeout(() => {
        this.element.value = maskedValue
      }, 1) // set masked value again after submit
    })
  }

  #symbolOptions () {
    if (this.symbolFirstValue) {
      return { prefix: `${this.symbolValue} ` }
    } else {
      return { suffix: ` ${this.symbolValue}` }
    }
  }
}
