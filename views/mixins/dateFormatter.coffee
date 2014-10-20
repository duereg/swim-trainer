module.exports = getFormattedDate: (date) ->
  "#{date.getFullYear()}-#{date.getMonth() + 1}-#{date.getDate()}"
