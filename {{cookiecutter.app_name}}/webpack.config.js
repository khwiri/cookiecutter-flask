const path = require('path');


module.exports = {
    mode: 'production',
    devtool: 'source-maps',
    entry: {
        main: './{{ cookiecutter.app_name }}/static-src/js/main.js',
    },
    output: {
        path: path.resolve(__dirname, './{{ cookiecutter.app_name }}/static/js'),
        filename: '[name].min.js',
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['babel-preset-env'],
                    },
                },
            },
        ],
    },
};
