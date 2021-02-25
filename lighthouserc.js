module.exports = {
  ci: {
    collect: {
      settings: {
        chromeFlags: '--disable-gpu --no-sandbox',
      },
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
