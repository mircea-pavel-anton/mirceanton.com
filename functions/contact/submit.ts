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
  name: 'Mircea Anton: mailbot',
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

  // Send notification mail to user
  var response = await sendMail({
    dest: person,
    subject: "Thank you for contacting me!",
    message: `
    <html>
      <head>
        <title>Thank you for contacting me!</title>
      </head>
      <body>
        <h2>Hello, ${person.name},</h2>

        <p>
        Thank you for taking the time to reach out.
        </p>

        <p>
        This is an automated message to notify you that I have received your email. I will read it and reply to you as soon as I possibly can!
        </p>

        <p>
        Please note that this email is sent from a no-reply address. I will not receive any replies to this email. If you have any additional questions or concerns, please reach out via the contact form or any of the other links in the <a href="https://mirceanton.com/contact">contact page</a>.
        </p>

        <i>
        beep-boop,<br>
        <b>Mr. Robot</b>
        </i>
      </body>
    </html>
    `
  })

  // Send mail to me
  response = await sendMail({
    dest: CONTACT_EMAIL,
    subject: "Form Submission: " + subject,
    message: `
    <html>
      <head>
        <title>You have a new contact form submission!</title>
      </head>
      <body>
        <p>From: ${person.name} ( ${person.email} )</p>
        <p>On: ${(new Date()).toUTCString()}</p>
        Message:<br>
        <hr>
        ${message}
        <hr>

        <i>
        beep-boop,<br>
        <b>Mr. Robot</b>
        </i>
      </body>
    </html>
    `,
  })

  return Response.redirect('https://mirceanton.com/')
}

async function sendMail({dest, from, subject, message}: MailParams) {
  return await fetch(new Request('https://api.mailchannels.net/tx/v1/send', {
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
          type: 'text/html',
          value: message,
        },
      ],
    }),
  }));
}