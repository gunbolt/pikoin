LedgerEntry = Data.define(:label, :income, :expense, :running_total) do
  def balance
    income + expense
  end
end
