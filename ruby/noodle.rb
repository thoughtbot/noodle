invocation_counts = ARGF.inject(Hash.new(0)) do |counts, invocation|
  if inv = invocation.split(/\s+/).first
    counts[inv] += 1
  end
  counts
end

invocation_counts
  .sort_by { |invocation, count| -1 * invocation.length * count }
  .each { |invocation, count| puts "#{invocation}: #{invocation.length * count}" }
