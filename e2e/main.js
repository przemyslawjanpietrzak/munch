const puppeteer = require('puppeteer');
const { assert } = require('chai');

const options = {
    width: 1920,
    height: 1080,
};

(async () => {
  const browser = await puppeteer.launch({
    headless: false,
    args: [`--window-size=${options.width},${options.height}`],
  });
  const page = await browser.newPage();
  await page.setViewport({
    width: 1920,
    height: 1080,
  });
  await page.goto('http://localhost:8000/index.html');

  await page.waitForSelector('#nav');

//   await page.click('#input');
//   await page.type('show me Starry Night');
  await page.click('#send');

  await page.waitForSelector('[data-testid="message-user"]');
  const messageElement1 = await page.$eval('[data-testid="message-user"] [data-testid="message-content"]', element => element.innerText);
  assert(messageElement1, 'show me Allegory');

  await browser.close();
})();
