// import { fs } from "node:fs";
// import { minify } from "terser";

// const fs = require('fs');
// const fs = require('fs');
// const { minify } = require('terser');

import { minify } from "terser";
import { readFile, open, readFileSync, writeFileSync, writeFile } from "node:fs";
import { basename, extname, relative, resolve } from 'node:path';
import minifyXML from "minify-xml";
// import htmlMinify from 'html-minifier';
import { globSync } from 'glob';
import { minify as minifycss } from 'csso';

/**
 * FUNGSI SCRIPT INI
 * Digunkan untuk mencopy meminify seluruh file di dist folder
 */

function scan(path) {
    let totalFiles = [];
    const files = globSync([path]);
    files.forEach(relUri => {
        if (!extname(relUri)) {
            path += '/*';
            totalFiles = totalFiles.concat(scan(path));
        } else {
            totalFiles.push(relUri);
        }
    })
    files.map(relUri => resolve(relUri));
    return [...new Set(totalFiles)];
}

function getAllFile(folder) {
    // folder = ['dist/Attributes/*']
    let allFiles = []
    folder.forEach(p => {
        const scanned = scan(p);
        allFiles = allFiles.concat(scanned);
    });
    return [...new Set(allFiles)];
}

// console.log(getAllFile(['dist/Attributes/*']));

function startMinifying(folders) {
    // folders = ['dist/Attributes/*']
    const allFiles = getAllFile(folders);
    allFiles.map(file => {
        return resolve(file);
    });
    allFiles.forEach(uri => {
        readFile(uri, 'utf-8', async (err, data) => {
            const ext = extname(uri);
            if (ext === '.xml' || ext === '.xsl' || ext === '.xsd' || ext === '.html') {
                const min = minifyXML(data,{
                    removeComments:true,
                    removeWhitespaceBetweenTags:true,
                    considerPreserveWhitespace:true,
                    collapseWhitespaceInTags:true,
                    collapseEmptyElements:false, // harus false
                    trimWhitespaceFromTexts:true,
                    collapseWhitespaceInTexts:false,
                    collapseWhitespaceInProlog:true,
                    collapseWhitespaceInDocType:true,
                    removeSchemaLocationAttributes:false,
                    removeUnnecessaryStandaloneDeclaration:false,
                    removeUnusedNamespaces:false, // harus false
                    removeUnusedDefaultNamespace:false,
                    shortenNamespaces:false,
                    ignoreCData:false,
                })
                writeFileSync(uri, min, 'utf-8');
            } else if (ext === '.js'){
                const min = await minify([data]);
                writeFileSync(uri, min.code, 'utf-8');
            } else if (ext === '.css'){
                const min = minifycss(data);
                writeFileSync(uri, min.css, 'utf-8');
            }
        })
    })
    // console.log(attributes);
}

const folders = ['dist' ];
startMinifying(folders);




// var cacheFileName = "/dist/js/functions.js";
// var cacheFileName = resolve('./dist/js/function.js');
// var cacheFileName = "D:/data_ferdi/application/S1000D/doc_v5/data_dictionary_50-000_02/Files/dist/js/functions.js";
// var cacheFileName = "D:/data_ferdi/application/S1000D/doc_v5/data_dictionary_50-000_02/Files/dist/Elements/accessory.xml";
// D:\data_ferdi\application\S1000D\doc_v5\data_dictionary_50-000_02\Files\dist\js\functions.js"
// var options = {
//     mangle: {
//         properties: true,
//     },
// nameCache: JSON.parse(fs.readFileSync(cacheFileName, "utf8"))
// };
// console.log(extname(cacheFileName));
// fs.writeFileSync("part1.js", await minify({
//     "file1.js": fs.readFileSync("file1.js", "utf8"),
//     "file2.js": fs.readFileSync("file2.js", "utf8")
// }, options).code, "utf8");
// fs.writeFileSync("part2.js", await minify({
//     "file3.js": fs.readFileSync("file3.js", "utf8"),
//     "file4.js": fs.readFileSync("file4.js", "utf8")
// }, options).code, "utf8");



// const buffer = readFileSync(cacheFileName);// buffer
// const text = writeFileSync('foo', buffer);
// const text = await writeFile('foo', buffer);
// console.log(text);
// const min = await minify(readFileSync(cacheFileName));
// console.log(min);
// writeFileSync(cacheFileName, min, "utf8");