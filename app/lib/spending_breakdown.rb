SpendingBreakdown = Data.define(:items)
SpendingBreakdown::Item = Data.define(:label, :color, :total)
