module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './node_modules/flowbite/**/*.js'
  ],
  plugins: [
    require('flowbite/plugin')
  ],
  theme: {
    extend: {
      keyframes: {
        'appear-then-fade': {
          '0%, 100%': { opacity: 0 },
          '5%, 60%': { opacity: 1 }
        }
      },
      animation: {
        'appear-then-fade': 'appear-then-fade 8s both'
      }
    }
  }
}
