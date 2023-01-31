export default {
  async fetch(request, env) {
    await delay(5000)
    return Response.redirect('https://mirceanton.com/thankyou')
  }
}

function delay(ms: number) {
  return new Promise( resolve => setTimeout(resolve, ms) );
}