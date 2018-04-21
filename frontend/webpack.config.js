const path = require("path");
const webpack = require("webpack");
const HTMLWebpackPlugin = require("html-webpack-plugin");

var MODE = process.env.npm_lifecycle_event === "prod" ? "production" : "development";
var filename = MODE == "production" ? "[name]-[hash].js" : "index.js";
console.log(MODE, filename);

var common = {
    mode: MODE,
    entry: "./src/index.js",
    output: {
        path: path.join(__dirname, "dist"),
        filename: filename
    },
    plugins: [
        new HTMLWebpackPlugin({
            template: "src/index.html",
            inject: "body"
        })
    ],
    resolve: {
        modules: [path.join(__dirname, "src"), "node_modules"],
        extensions: [".js", ".elm", ".scss", ".png"]
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: "babel-loader"
                }
            },
            {
                test: /\.scss$/,
                exclude: [/elm-stuff/, /node_modules/],
                loaders: ["style-loader", "css-loader", "sass-loader"]
            },
            {
                test: /\.css$/,
                exclude: [/elm-stuff/, /node_modules/],
                loaders: ["style-loader", "css-loader"]
            },
            {
                test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: "url-loader",
                options: {
                    limit: 10000,
                    mimetype: "application/font-woff"
                }
            },
            {
                test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: "file-loader"
            },
            {
                test: /\.(jpe?g|png|gif|svg)$/i,
                loader: "file-loader"
            }
        ]
    }
};

if (MODE === "development") {
    module.exports = { ...common,
        plugins: [
            new webpack.NamedModulesPlugin(),
            new webpack.NoEmitOnErrorsPlugin()
        ],
        module: {
            rules: [
                {
                    test: /\.elm$/,
                    exclude: [/elm-stuff/, /node_modules/],
                    use: [
                        {
                            loader: "elm-hot-loader"
                        },
                        {
                            loader: "elm-webpack-loader",
                            options: {
                                debug: true
                            }
                        }
                    ]
                }
            ]
        },
        devServer: {
            inline: true,
            stats: "errors-only",
            contentBase: path.join(__dirname, "src"),
            historyApiFallback: true,
            proxy: {
              "/painting": "http://munch/today"
            }
        }
    };
}

if (MODE === "production") {
    module.exports = merge(common, {
        plugins: [],
        module: {
            rules: [
                {
                    test: /\.elm$/,
                    exclude: [/elm-stuff/, /node_modules/],
                    use: [
                        {
                            loader: "elm-webpack-loader"
                        }
                    ]
                }
            ]
        }
    });
}