package noodle

import "testing"
import "noodle"

func TestParseLine(t *testing.T) {
  line := "  32 rake"
  actual := ParseLine(line)
  expected := "rake"
  if actual != expected {
    t.Errorf("want %v, got %v", expected, actual)
  }
}
