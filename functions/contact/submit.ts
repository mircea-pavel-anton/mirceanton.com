export async function onRequestPost({ request, env }) {
  const formData = await request.formData();
  const name = formData.get("Name")
  const email = formData.get("Email")
  const subject = formData.get("Subject")
  const message = formData.get("Message")

  return Response.json({
    name: name,
    email: email,
    subject: subject,
    message: message
  })
}
