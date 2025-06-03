# Fruit Salad Events

## A [PlaceCal](https://placecal.org/) community site

Front-end for the [Fruit Salad Events PlaceCal](https://fruitsaladevents.placecal.org/), an online community calendar for LGBTQIA+ events that prioritise accessibility, conversation and conversation.

-  Staging url: 
-  Production URL: https://fruitsaladevents.co.uk

# Development

## Prerequisites

- [node](https://nodejs.org/)
- [nvm for macOS & Linux](https://github.com/nvm-sh/nvm) or [nvm for Windows](https://github.com/coreybutler/nvm-windows)

## Setup & install instructions

- make sure you are using the correct node version with `nvm use`
- install with `npm install`

Copy `.env.example` over into `.env` and edit if necessary. This must be done before any of the following will work as it generates `src/Constants.elm` which is used in a number of places in the code.

Edit `elm-pages.config.mjs` to include the meta information for your site.

## Build

- `npm start` to start a dev server on http://localhost:3030
- `npm run build` generate a production build in `dist/`

## Formatting

- There is a pre-commit hook that runs `elm-format --yes`. This will format your files when you commit. This might interfere with the state of files in your IDE. So, we recommend integrating `elm-format@0.8.3` on save into your code editor.
- You can also manually run `npm run format` to format `.elm` files in `src`.

## Testing

We're using [elm-test-rs](https://github.com/mpizenberg/elm-test-rs) to run [elm tests](https://package.elm-lang.org/packages/elm-explorations/test/latest/). It is required to run either `npm start` (quickest) or `npm build` at least once in the project before tests will work.

- run tests with `npm test`

## Code & configs

### This site is built with `elm-pages`

- [Documentation site](https://elm-pages.com)
- [Elm Package docs](https://package.elm-lang.org/packages/dillonkearns/elm-pages/latest/)
- [`elm-pages` blog](https://elm-pages.com/blog)

### What it's for

- `elm.json` for elm packages used for site
- `elm-tooling.json` for elm packages used for code
- `.env` is used to generate `src/Constants.elm` for elm-pages
- `script/*` contains CLI code generation scripts to generate boilerplate for new `elm-pages` routes
- `.nvmrc` contains project node version
- `package.json` for node scripts and packages
- `package-lock.json` for current versions of node packages
- `app/*` contains core files required by `elm-pages`. These are boilerplate altered for this project.
- `src/*` contains custom files. These were authoured specifically for this template.
  - `src/Data/PlaceCal` contains code for fetching, caching and decoding data from PlaceCal
  - `src/Helpers/` contains utility code (e.g. for handling dates)
  - `src/Theme/` contains view code like templates and shared styling
- `theme/*` contains stuff specific to your site
- `public/*` contains static files to be copied direct to build like image assets and css
- `tests/*` contains test files

### Pages

- Routes in `app/Route/` automatically generate route based on file name
- New routes can be generated via CLI
  - e.g. create a new stateless route by running `npx elm-pages run AddStaticStatelessRoute MyRouteName`
- Page templates are in `src/Theme/Page/`

### Styling & layouts

- We are using [elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/Css) for styling

## Deployment

Deploys to Cloudflare Pages

-  code is tested and linted automatically before deploy
-  when a pull request is created, a preview site is deployed
-  when a pull request is merged into `main`, the production site is deployed

## Development workflow

### Adding issues

-  add effort & value labels (if you know enough about it)

### Working on issue

-  assign it to yourself before starting work
-  make a branch that includes the issue type (fix/feat/chore etc & number)
-  make sure you understand the acceptance criteria
-  don't forget to include tests if it's a new feature
-  ask questions & make plan

### Code review & merge

-  check the acceptance criteria have been met (with tests if appropriate)
-  add comments & questions
-  once approved, leave for the author to merge

## License

Source code is released under the [Hippocratic License](https://firstdonoharm.dev/version/3/0/license/).

Design by by [Geeks for Social Change](https://gfsc.studio/).

## Contributing

We welcome new contributors, but please drop us a message before you start - we will be happy to onboard you properly before you get stuck in.
