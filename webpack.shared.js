/**
 * External Dependencies
 */
var path = require( 'path' );
var webpack = require( 'webpack' );

module.exports = {
	target: 'node',
	module: {
		loaders: [
			{
				test: /\.html$/,
				loader: 'html-loader'
			},
			{
				test: /\.json$/,
				loader: 'json-loader'
			},
			{
				test: /\.jsx?$/,
				loader: 'babel-loader',
				exclude: /node_modules/
			}
		]
	},
	node: {
		__filename: true,
		__dirname: true
	},
	externals: [
		'webpack',
		'superagent',
		'electron',
		'component-tip',
	],
	resolve: {
		extensions: [ '', '.js', '.jsx' ],
		modulesDirectories: [ 'node_modules', 'app' ]
	},
	plugins: [
		// new webpack.optimize.DedupePlugin(),
		new webpack.optimize.OccurenceOrderPlugin(),
		new webpack.NormalModuleReplacementPlugin( /^lib\/analytics$/, 'lodash/noop' ), // Depends on BOM
		new webpack.NormalModuleReplacementPlugin( /^lib\/upgrades\/actions$/, 'lodash/noop' ), // Uses Flux dispatcher
		new webpack.NormalModuleReplacementPlugin( /^lib\/route$/, 'lodash/noop' ), // Depends too much on page.js
		new webpack.NormalModuleReplacementPlugin( /^my-sites\/themes\/thanks-modal$/, 'components/empty-component' ), // Depends on BOM
		new webpack.NormalModuleReplacementPlugin( /^my-sites\/themes\/themes-site-selector-modal$/, 'components/empty-component' ) // Depends on BOM
	],
};
