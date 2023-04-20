const puppeteer = require('puppeteer');

(async () => {
//  const username = 'me@hradec.com';
//  const password = 'tuctuc';
  const username = process.env.USERNAME;
  const password = process.env.PASSWORD;
  console.log('username: '+username)
  console.log('password: '+password)

  // Launch a new headless browser instance
  const browser = await puppeteer.launch({
      headless: true,
      executablePath: process.env.CHROME
  });
  //const browser = await puppeteer.launch({ headless: false });

  // Create a new page in the browser
  const page = await browser.newPage();

  // Navigate to the login page
  await page.goto('https://www.sidefx.com/login/');

  // Click the submit button and wait for navigation
  await Promise.all([
    page.waitForNavigation({ waitUntil: 'load' }),
    await page.type('#id_username', username),
    await page.type('#id_password', password),
    page.click('.btn-primary'),
    page.waitForNavigation({ waitUntil: 'networkidle0' }),
  ]);

  // Navigate to the daily builds page
  await page.goto('https://www.sidefx.com/download/daily-builds/?production=true', {
      timeout: 20000,
      waitUntil: ['load', 'domcontentloaded', 'networkidle0', 'networkidle2']
  });

  // Perform any scraping tasks or save the content of the page
  const content = await page.content();
  // console.log('bumm.tar.gz');
  console.log(content);

  // Close the browser
  await browser.close();
})();
