const path = require("path");
const webpack = require("webpack");
const HTMLWebpackPlugin = require("html-webpack-plugin");
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

var MODE = process.env.npm_lifecycle_event === "prod" ? "production" : "development";
var filename = MODE == "production" ? `[name].${hash[name]}.js` : "[name].js";

const hash =  (() => {
    var text = "";
    var possible = "abcdefghijklmnopqrstuvwxyz0123456789";
  
    for (var i = 0; i < 10; i++)
      text += possible.charAt(Math.floor(Math.random() * possible.length));
  
    return text;
})();

var common = {
    mode: MODE,
    entry: {
        index: "./src/index.js",
        sw: "./service-worker.js",
    },
    output: {
        path: path.join(__dirname, "../nginx/dist"),
        filename: filename
    },
    plugins: [
        new HTMLWebpackPlugin({
            template: "src/index.html",
        })
    ],
    resolve: {
        modules: [path.join(__dirname, "src"), "node_modules"],
        extensions: [".js", ".elm"]
    },
    devtool: process.env.NODE_ENV ? 'none' : 'source-map',
    module: {
        rules: [{
            test: /\.js$/,
            exclude: /node_modules/,
            use: [{
                loader: 'babel-loader',
                options: {
                    presets: ['env'],
                    plugins: []
                }
            }, {
                loader: 'string-replace-loader',
                options: {
                    search: '\__STATIC_FILE_HASH__',
                    replace: hash,
                    flags: 'g',
                }
            }]
        }, {
            test: /\.css$/,
            use: [
              process.env.NODE_ENV !== 'production' ? 'style-loader' : MiniCssExtractPlugin.loader,
              'css-loader',
            ]
          },],
    }
};

if (MODE === "development") {
    module.exports = {
        ...common,
        plugins: [
            ...common.plugins,
            new webpack.NamedModulesPlugin(),
            new webpack.NoEmitOnErrorsPlugin(),
        ],
        module: {
            rules: [
                ...common.module.rules,
                {
                    test: /\.elm$/,
                    exclude: [/elm-stuff/, /node_modules/],
                    use: [{
                            loader: "elm-hot-loader"
                        },
                        {
                            loader: "elm-webpack-loader",
                            options: {
                                debug: true
                            }
                        }
                    ]
                },
            ]
        },
        devServer: {
            contentBase: path.join(__dirname, 'dist'),
            historyApiFallback: true,
            compress: true,
            proxy: {
                "/painting": "http://localhost"
            }
        }
    };
}

if (MODE === "production") {
    module.exports = {
        ...common,
        module: {
            rules: [
                ...common.module.rules,
                {
                    test: /\.elm$/,
                    exclude: [/elm-stuff/, /node_modules/],
                    use: [{
                        loader: "elm-webpack-loader"
                    }]
                }
            ]
        }
    };
}