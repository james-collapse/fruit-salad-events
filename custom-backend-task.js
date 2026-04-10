// custom-backend-task.js
import path from 'node:path';
import fs from 'node:fs/promises';
import { constants } from 'node:fs';
import fetch from 'make-fetch-happen';

const fetchOpts = {
  retry: { retries: 3, minTimeout: 1000 },
  timeout: 30000
};

async function fetchAndCachePlaceCalData(config, context) {
  let placeCalData = null;
  const cacheDir = path.join(context.cwd, '.cache');
  const cachePath = path.join(cacheDir, `${config.collection}.json`);
  try {
    await fs.access(cacheDir, constants.F_OK);
  } catch (_error) {
    await fs.mkdir(cacheDir, { recursive: true });
  }

  try {
    const fileContent = await fs.readFile(cachePath, 'utf8');
    placeCalData = JSON.parse(fileContent);
  } catch (_error) {
    const response = await fetch(config.url, {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ query: config.query.query }),
      ...fetchOpts
    });

    if (!response.ok) {
      throw new Error(`Failed to fetch data: ${response.statusText}`);
    }

    const collectionJson = await response.json();

    if (collectionJson.errors) {
      throw new Error(`GraphQL errors: ${JSON.stringify(collectionJson.errors)}`);
    }

    await fs.writeFile(cachePath, JSON.stringify(collectionJson));
    placeCalData = collectionJson;
  }
  return placeCalData;
}

export {
  fetchAndCachePlaceCalData
};
