import mailChannelsPlugin from "@cloudflare/pages-plugin-mailchannels";

export const onRequest: PagesFunction = mailChannelsPlugin({
  personalizations: [
    {
      to: [
        {
          name: "Mircea-Pavel ANTON",
          email: "contact@mirceanton.com" 
        }
      ],
    },
  ],
  from: {
    name: "M.P.A. mail bot",
    email: "noreply@mirceanton.com",
  }, respondWith: () => {
    return new Response(`Thank you for submitting your enquiry. A member of the team will be in touch shortly.`);
  },
});
