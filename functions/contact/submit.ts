interface MailParams {
  dest: {
    email: string,
    name: string,
  },
  from?: {
    name: string,
    email: string,
  }
  subject: string,
  message: string,
}

const NOREPLY_FROM = {
  name: 'Mircea Anton - mailbot',
  email: 'noreply@mirceanton.com',
}
const CONTACT_EMAIL = {
  name: "Mircea Anton",
  email: "contact@mirceanton.com",
}

export async function onRequestPost({ request, env }) {
  const formData = await request.formData();
  const person = {
    name: formData.get("Name"),
    email: formData.get("Email")
  }
  const subject = formData.get("Subject")
  const message = formData.get("Message")
  console.log(`
    Extracted form data:
    person: {
      name: ${person.name},
      email: ${person.email},
    },
    subject: ${subject},
    message: ${message},
  `)

  // Send notification mail to user
  var response = await sendMail({
    dest: person,
    subject: "Thank you for contacting me!",
    message: `
      Hello, ${person.name},

      Thank you for taking the time to get in touch. This is an automated email sent to notify you that I have received your email.
      I will read it and reply as soon as I possibly can!

      Thank you,
      Mircea ANTON
    `,
  })
  console.log(await response.text)

  // // Send mail to me
  // response = await sendMail({
  //   dest: CONTACT_EMAIL,
  //   subject: "Form Submission: " + subject,
  //   message: message,
  // })
  // console.log(await response.text)

  return Response.redirect('https://mirceanton.com/')
}

async function sendMail({dest, from, subject, message}: MailParams) {
  return await new Request('https://api.mailchannels.net/tx/v1/send', {
    method: 'POST',
    headers: {
      'content-type': 'application/json',
    },
    body: JSON.stringify({
      personalizations: [
        {
          to: [dest],
        },
      ],
      from: from ?? NOREPLY_FROM,
      subject: subject,
      content: [
        {
          type: 'text/plain',
          value: message,
        },
      ],
    }),
  });
}