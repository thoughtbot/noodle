package main

import (
  "fmt"
  "bufio"
  "io"
  "os"
  "strings"
  "sort"
  "math"
  "strconv"
)

type sortedCommands struct {
        counts map[string]int
        order []string
}

func (commands *sortedCommands) Len() int {
        return len(commands.counts)
}

func (commands *sortedCommands) Less(i, j int) bool {
        return weight(commands.order[i], commands.counts[commands.order[i]]) > weight(commands.order[j], commands.counts[commands.order[j]])
}

func (commands *sortedCommands) Swap(i, j int) {
        commands.order[i], commands.order[j] = commands.order[j], commands.order[i]
}

func sortCommands(counts map[string]int) sortedCommands {
        commands := new(sortedCommands)
        commands.counts = counts
        commands.order = make([]string, len(counts))
        i := 0
        for key, _ := range counts {
                commands.order[i] = key
                i++
        }
        sort.Sort(commands)

        return *commands
}

func weight(name string, count int) int {
  return len(name) * count
}

func readCounts(reader io.Reader) map[string]int {
        counts := make(map[string]int)
        scanner := bufio.NewScanner(reader)

        for scanner.Scan() {
                words := strings.Fields(scanner.Text())

                if len(words) >= 2 {
                      command := words[1]
                      counts[command]++
                }
        }

        return counts
}

func printSorted(commands sortedCommands) {
        for _, command := range commands.order {
                count := commands.counts[command]
                fmt.Printf("%s: %d times\n", command, count)
        }
}

func main() {
        counts := readCounts(os.Stdin)
        commands := sortCommands(counts)

        lim := 10
        args := os.Args

        if len(args) >= 2 {
          lim, _ = strconv.Atoi(args[1])
        }

        lim = int(math.Min(float64(lim), float64(len(commands.order))))

        commands.order = commands.order[0:lim]

        printSorted(commands)
}
