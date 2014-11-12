module.exports = function(res) {
  // apiError => {error: body-of-response, options: requestOptions,
  //              response: full-response-object, statusCode: full-response-object.statusCode}
  return function(apiError) {
    console.warn("Caught API error:", JSON.stringify(apiError));
    if (apiError && apiError.statusCode && apiError.error) {
      res.status(apiError.statusCode).send(apiError.error);
    } else if (apiError && apiError.status && apiError.detail) {
      res.status(parseInt(apiError.status)).send({errors: [apiError]});
    } else if (apiError) {
      res.status(500).send({errors: [apiError]});
    }
    return res;
  };
};
