#!/usr/bin/env ruby

invocation_counts = STDIN.inject(Hash.new(0)) do |counts, invocation|
  if inv = invocation.strip.split(/\s+/)[1]
    counts[inv] += 1
  end
  counts
end

invocation_counts
  .sort_by { |invocation, count| -1 * invocation.length * count }
  .take((ARGV[0] || 10).to_i)
  .each { |invocation, count| puts "#{invocation}: #{count} times" }
