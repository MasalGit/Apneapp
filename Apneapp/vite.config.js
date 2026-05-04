import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { defineConfig } from 'vite';

const __dirname = dirname(fileURLToPath(import.meta.url));

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        home: resolve(__dirname, 'index.html'),
        graph: resolve(__dirname, 'graph.html'),
        viikoteh: resolve(__dirname, 'forgot-password.html'),
        dashboard: resolve(__dirname, 'dashboard.html'),
      },
    },
  },
  // Public base path could be set here too:
  //base: '/~ullamu/hyte/',
  base: './',
});