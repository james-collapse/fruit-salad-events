import { defineConfig } from "vite";
import adapter from "elm-pages/adapter/netlify.js";

export default {
  vite: defineConfig({}),
  adapter,
  headTagsTemplate(context) {
    return `
  <link rel="stylesheet" href="/style.css" />
  <meta name="generator" content="elm-pages v${context.cliVersion}" />
  <link href="https://api.fontshare.com/v2/css?f[]=satoshi@300,301,400,401,500,501,700,701,900,901&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://use.typekit.net/wsk1oct.css" />
  `;
  },
  preloadTagForFile(file) {
    // add preload directives for JS assets and font assets, etc., skip for CSS files
    // this function will be called with each file that is procesed by Vite, including any files in your headTagsTemplate in your config
    return !file.endsWith(".css");
  },
};
