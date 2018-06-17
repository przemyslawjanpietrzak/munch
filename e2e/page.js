const { expect } = require('chai');

const navSelector = '#munch';
const userMessageSelector = '[data-testid="message"][data-test-type="user"]';
const botMessageSelector = '[data-testid="message"][data-test-type="bot"]';
const contentSelector = '[data-testid="message-content"]';
const sendButtonSelector = '#send';
const inputSelector = '#input';

module.exports = (page) => ({
    assertMessageContent: async ({ messageIndex, expectedContent, isBot = false }) => {
        const messageSelector = isBot ? botMessageSelector : userMessageSelector;

        await page.waitForSelector(`${messageSelector}:nth-of-type(${messageIndex}) ${contentSelector}`);
        const message = await page.$eval(`${messageSelector}:nth-of-type(${messageIndex}) ${contentSelector}`, element => element.innerText);
        expect(message).to.equal(expectedContent);
    },
    sendMessage: async (message) => {
        await page.type(inputSelector, message, { delay: 10 });
        await page.click(sendButtonSelector);
    },
    waitForPage: async () => {
        await page.waitForSelector(navSelector);
    }
});
