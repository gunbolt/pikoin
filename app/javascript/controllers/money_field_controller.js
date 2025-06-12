import { Controller } from '@hotwired/stimulus'
import SimpleMaskMoney from 'simple-mask-money'

// Connects to data-controller="money-field"
export default class extends Controller {
  static values = {
    allowNegative: Boolean,
    decimalSeparator: String,
    thousandsSeparator: String,
    fractionDigits: Number
  }

  connect () {
    this.setupInput()
    this.setupUnmaskOnSubmit()
  }

  setupInput () {
    SimpleMaskMoney.setMask(this.element, {
      allowNegative: this.allowNegativeValue,
      decimalSeparator: this.decimalSeparatorValue,
      thousandsSeparator: this.thousandsSeparatorValue,
      fractionDigits: this.fractionDigitsValue,
      fixed: true,
      cursor: 'end'
    })
  }

  setupUnmaskOnSubmit () {
    this.element.form.addEventListener('submit', () => {
      const maskedValue = this.element.value
      this.element.value = maskedValue.replace(/[^0-9-]/g, '') // keep numeric characters
      setTimeout(() => {
        this.element.value = maskedValue
      }, 1) // set masked value again after submit
    })
  }
}
