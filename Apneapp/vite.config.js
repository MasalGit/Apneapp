import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { defineConfig } from 'vite';

const __dirname = dirname(fileURLToPath(import.meta.url));

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        home: resolve(__dirname, 'index.html'),
        dashboard: resolve(__dirname, 'dashboard.html'),
        graph: resolve(__dirname, 'graph.html'),
        about: resolve(__dirname, 'about.html'),
        asetukset: resolve(__dirname, 'asetukset.html'),
        raportit: resolve(__dirname, 'raportit.html'),
        forgot: resolve(__dirname, 'forgot-password.html'),
      },
    },
  },
  // Public base path could be set here too:
  //base: '/~ullamu/hyte/',
  base: './',
});