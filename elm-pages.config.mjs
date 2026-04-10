import adapter from "elm-pages/adapter/netlify.js";

export default {
  adapter,
  vite: {
    plugins: [
      /**/
    ],
  },
  headTagsTemplate(context) {
    return `
<link rel="stylesheet" href="/style.css" />
<meta name="generator" content="elm-pages v${context.cliVersion}" />
<link href="https://api.fontshare.com/v2/css?f[]=satoshi@300,301,400,401,500,501,700,701,900,901&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="https://use.typekit.net/wsk1oct.css" />
`;
  },
  preloadTagForFile(file) {
    return !file.endsWith(".css");
  },
};

