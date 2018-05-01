const puppeteer = require('puppeteer');

const getPageObject = require('./page');
const { width, height, headless } = require('./settings');


let browser;
let pageObject;
let page;

beforeAll(async () => {
  browser = await puppeteer.launch({
    headless:  headless,
    args: [`--window-size=${width},${height}`],
  });
  page = await browser.newPage();
  pageObject = getPageObject(page);

  await page.goto('http://localhost/index.html');
});

afterAll(() => {
  browser.close();
});

test('find 3 pictures', async () => {
  await page.setViewport({
    width,
    height,
  });

  await pageObject.waitForPage();
  await page.click('#send');

  await pageObject.assertMessageContent({ messageIndex: 1, expectedContent: 'show me Allegory' });
  await pageObject.assertMessageContent({ messageIndex: 2, expectedContent: 'https://www.wga.hu/html/a/aachen/allegory.html', isBot: true });

  await pageObject.sendMessage('show me Starry Night');
  
  await pageObject.assertMessageContent({ messageIndex: 3, expectedContent: 'show me Starry Night' });
  await pageObject.assertMessageContent({ messageIndex: 4, expectedContent: 'https://www.wga.hu/html/g/gogh_van/12/cypres01.html', isBot: true });

  await pageObject.sendMessage('Lorem Ipsum');
  
  await pageObject.assertMessageContent({ messageIndex: 5, expectedContent: 'Lorem Ipsum' });
  await pageObject.assertMessageContent({ messageIndex: 6, expectedContent: 'Not found', isBot: true });

});
