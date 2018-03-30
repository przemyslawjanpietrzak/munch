const puppeteer = require('puppeteer');

const getPageObject = require('./page');

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
  const pageObject = getPageObject(page);

  await page.setViewport({
    width: options.width,
    height: options.height,
  });
  await page.goto('http://localhost:8000/index.html');

  await pageObject.waitForPage();
  await page.click('#send');

  await pageObject.assertMessageContent({ messageIndex: 1, expectedContent: 'show me Allegory' });
  await pageObject.assertMessageContent({ messageIndex: 2, expectedContent: 'https://www.wga.hu/html/a/aachen/allegory.html', isBot: true });

  await pageObject.sendMessage('show me Starry Night');
  
  await pageObject.assertMessageContent({ messageIndex: 3, expectedContent: 'show me Starry Night' });
  await pageObject.assertMessageContent({ messageIndex: 4, expectedContent: 'https://www.wga.hu/html/a/aachen/allegory.html', isBot: true });

  await browser.close();
})();
