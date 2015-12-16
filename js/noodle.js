'use strict';

var ITEMS_TO_PRINT = process.argv[2] || 10;

readLines(function analyze(lines) {
  var countsByCommand = lines
    .map(extractCommandName)
    .reduce(collectCountsByCommand, {});

  hashToArray(countsByCommand)
    .map(addWeight)
    .sort(descendingByWeight)
    .slice(0, ITEMS_TO_PRINT)
    .forEach(print);
});

function readLines(callback) {
  var readline = require('readline');
  var stdinReader = readline.createInterface({
    input: process.stdin
  });

  var lines = [];

  stdinReader
    .on('line', lines.push.bind(lines))
    .on('close', callback.bind(this, lines));
}

function extractCommandName(line) {
  return line.trim().split(/\s+/)[1];
}

function collectCountsByCommand(counts, command) {
  if (command in counts) counts[command]++;
  else counts[command] = 1;

  return counts;
}

function hashToArray(hash) {
  var array = [];

  for (var key in hash) {
    array.push({command: key, count: hash[key]});
  }

  return array;
}

function addWeight(record) {
  record.weight = record.command.length * record.count;

  return record;
}

function descendingByWeight(record1, record2) {
  return record2.weight - record1.weight;
}

function print(record) {
  console.log('%s: %d times', record.command, record.count);
}
