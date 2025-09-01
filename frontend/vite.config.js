import { defineConfig } from "vite";
import elmPlugin from 'vite-plugin-elm'

import { VitePWA } from 'vite-plugin-pwa'
import basicSsl from '@vitejs/plugin-basic-ssl'

export default defineConfig({
  base: '/kampu-law',
  plugins: [
    // basicSsl(),
    elmPlugin(),
    VitePWA({
      registerType: 'prompt',
      injectRegister: false,

      pwaAssets: {
        disabled: false,
        config: true,
      },

      manifest: {
        name: 'vite-project',
        short_name: 'vite-project',
        description: 'vite-project',
        theme_color: '#ffffff',
        orientation: 'portrait',
      },

      workbox: {
        globPatterns: ['**/*.{js,css,html,svg,png,ico}'],
        cleanupOutdatedCaches: true,
        clientsClaim: true,
      },

      devOptions: {
        enabled: false,
        navigateFallback: 'index.html',
        suppressWarnings: true,
        type: 'module',
      },
    })
  ],
});



