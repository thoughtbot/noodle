//
// TODO: read count from arguments
//
readLines(function(lines) {
  var countsByCommand = lines
    .map(trim)
    .map(split)
    .map(pluck)
    .sort()
    .reduce(countByCommand, {});

  console.log('countsByCommand', countsByCommand);

  function trim(line) {
    return line.trim();
  }

  function split(line) {
    return line.split(/\s+/);
  }

  function pluck(commandBits) {
    return commandBits[1];
  }

  function countByCommand(counts, command) {
    if (command in counts) counts[command]++;
    else counts[command] = 1;

    return counts;
  }
});


function readLines(processorFunction) {
  var readline = require('readline');
  var stdinReader = readline.createInterface({
    input: process.stdin
  });

  var lines = [];

  stdinReader
    .on('line', collectInto(lines))
    .on('close', processorFunction.bind(this, lines));

  function collectInto(lines) {
    return lines.push.bind(lines);
  }
}
