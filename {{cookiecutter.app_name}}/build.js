const path = require('path');
const { spawnSync } = require('child_process');
const { argv } = require('yargs');


function spawn(command, options) {
    const [cmd, ...args] = command.split(' ');
    const stdio = ['ignore', 'inherit', 'inherit'];

    spawnSync(cmd, args, {stdio: stdio, ...options});
}


function nodeSass({ input, output, compressed='compressed', sourceMaps=true, watch=false } = {}) {
    const args = [];

    args.push(...(compressed ? ['--output-style', compressed] : []));
    args.push(...(sourceMaps ? ['--source-map', path.dirname(output)] : []));
    args.push(...(watch ? ['--watch'] : []));

    spawn(['node-sass', ...args, input, output].join(' '));
}


const tasks = {
    appCSS({ watch=false } = {}) {
        nodeSass({
            input: './{{ cookiecutter.app_name }}/static-src/scss/main.scss',
            output: './{{ cookiecutter.app_name }}/static/css/main.min.css',
            watch: watch,
        });
    },

    appCopy() {
        spawn('copyfiles --up 3 ./{{ cookiecutter.app_name }}/static-src/img/**/* ./{{ cookiecutter.app_name }}/static/img');
        // more resource copying can be added here...
    },
};


const task = argv._.pop();
if(task in tasks)
    tasks[task](argv);

else
    throw new Error(`Unknown task:    ${task}\n       Available Tasks: ${Object.keys(tasks).join(', ')}\n`);
