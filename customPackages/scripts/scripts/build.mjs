// @ts-check
import * as esbuild from "esbuild"
import builtins from "builtin-modules"
import path from "node:path"
const scripts = ["./hash.ts"]
/**
 * @param {string} ep
*/
function buildScript(ep) {

    /**
     * @type {esbuild.BuildOptions}
    */
    const opts = {
        entryPoints: [ep],
        outdir: "dist",
        external: [...builtins],
        minify: true,
        bundle: true,
        platform: "node",
        format: "cjs",
        logLevel: "info"
    }

    esbuild.buildSync(opts)
}
scripts.forEach(buildScript)
