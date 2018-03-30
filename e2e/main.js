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
    width: options.width,
    height: options.height,
  });
  await page.goto('http://localhost:8000/index.html');

  await page.waitForSelector('#nav');

  await page.click('#send');

  await page.waitForSelector('[data-testid="message"][data-test-type="user"] [data-testid="message-content"]');
  const messageElement1 = await page.$eval('[data-testid="message"][data-test-type="user"] [data-testid="message-content"]', element => element.innerText);
  assert(messageElement1 === 'show me Allegory');

  await page.waitForSelector('[data-testid="message"][data-test-type="bot"] [data-testid="message-content"]');
  const messageElement2 = await page.$eval('[data-testid="message"][data-test-type="bot"] [data-testid="message-content"]', element => element.innerText);
  assert(messageElement2 === 'https://www.wga.hu/html/a/aachen/allegory.html');

  await page.type('#input', 'show me Starry Night', { delay: 10 });
  await page.click('#send');

  await page.waitForSelector('[data-testid="message"][data-test-type="user"]:nth-of-type(3) [data-testid="message-content"]');
  const messageElement3 = await page.$eval('[data-testid="message"][data-test-type="user"]:nth-of-type(3) [data-testid="message-content"]', element => element.innerText);
  assert(messageElement3 === 'show me Starry Night');

  await page.waitForSelector('[data-testid="message"][data-test-type="bot"]:nth-of-type(4) [data-testid="message-content"]');
  const messageElement4 = await page.$eval('[data-testid="message"][data-test-type="bot"]:nth-of-type(4) [data-testid="message-content"]', element => element.innerText);
  assert(messageElement4 === 'https://www.wga.hu/html/a/aachen/allegory.html');


  await browser.close();
})();
