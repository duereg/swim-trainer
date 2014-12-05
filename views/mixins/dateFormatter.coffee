formatDigit = (digit) ->
  digit = digit + ''
  if digit.length is 1
    digit = '0' + digit
  digit

module.exports =
  getFormattedDate: (date) ->
    date = new Date(date) unless date.getMonth?
    month = formatDigit(date.getMonth() + 1)
    day = formatDigit(date.getDate())

    "#{date.getFullYear()}-#{month}-#{day}"
