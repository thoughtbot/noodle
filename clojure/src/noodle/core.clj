(ns noodle.core)

(defn parse-history-line
  [line]
  (nth (clojure.string/split line #"\s+") 2))

(defn counts
  [commands]
  (frequencies commands))

(defn weight
  [acc v]
  (merge { (first v) (* (count (first v)) (second v)) } acc))

(defn weights
  [counts]
  (reduce weight {} counts))
