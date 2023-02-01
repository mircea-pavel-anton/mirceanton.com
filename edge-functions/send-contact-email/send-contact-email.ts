import type { Context } from "https://edge.netlify.com";

export default async (request: Request, _context: Context) => {
  const SENDGRID_API_KEY = Deno.env.get("SENDGRID_API_KEY");
  const formData = (await request.formData())
  const name = formData.get('Name')
  const subject = formData.get('Subject')
  const email = formData.get('Email')
  const message = formData.get('Message')

  console.log(SENDGRID_API_KEY);

  return Response.json(
    {
      name: name,
      email: email,
      subject: subject,
      message: message,
    }
  );
};