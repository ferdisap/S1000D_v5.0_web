import { defineConfig } from 'vite';
// import path from 'node:path';
// import { globSync } from 'glob';
// import { fileURLToPath } from 'node:url';
// import xml from "rollup-plugin-xml";

// var inp = Object.fromEntries(
//                 globSync(['js/*']).map(file => [
//                     path.relative('', file.slice(0, file.length - path.extname(file).length)),
//                     // path.relative('js', file.slice(0, 5)),
//                     fileURLToPath(new URL(file, import.meta.url))
//                 ]));
// var inp = globSync(['js/*']);
                
// console.log(inp);

export default defineConfig({
    // root: './',
    // publicDir: 'src',
    // plugins:[
    //     xml(),
    // ],
    build: {
        // minify: true,
        // lib: {
        //     entry: path.resolve(__dirname, 'js/main.js'),
        //     name: 'MyLib',
        //     fileName: (format, entryName) => `${entryName}.js`
        // },
        // lib: {
            // entry: globSync(['js/*']),
            // fileName: (format, entryName) => `${entryName}.xml`
        // },
        rollupOptions: {
            // input: "index.html",
            input: "src/Index.html",
            // input: globSync(['Attributes/*']),
            // input: Object.fromEntries(
            //     globSync(['Attributes/*']).map(file => [
            //         path.relative('', file.slice(0, file.length - path.extname(file).length)),
            //         // path.relative('js', file.slice(0, 5)),
            //         fileURLToPath(new URL(file, import.meta.url))
            //     ])
            // ),
            output: {
                dir: 'dist',
                // format: [ "amd", "cjs", "system", "es", "iife", "umd"],
                // format: "umd",
                // inlineDynamicImports: false,
                // path: path.resolve(__dirname, 'dist'),
            }
        }
    },
})
