Cashflow = Data.define(:expense, :income) do
  def balance = income + expense
end
