(ns noodle.core)

(defn history-line->command
  "Returns the command name a zsh_history-style line"
  [line]
  (nth (clojure.string/split line #"\s+") 2))

(defn counts
  [commands]
  (frequencies commands))

(defn print-one
  [[command weight]]
  (format "%s: %d\n" command weight))

(defn pretty-print
  [m]
  (clojure.string/join (map print-one m)))

(defn weight
  [m key1 key2]
  (compare [(* (get m key2) (count key2)) key2]
           [(* (get m key1) (count key1)) key1]))

(defn sort-by-weight
  [m]
  (into (sorted-map-by (partial weight m)) m))

(defn print-history-lines
  [history-lines]
  ((comp
     pretty-print
     (partial take 10)
     sort-by-weight
     counts
     (partial map history-line->command))
   history-lines))

(defn main
  []
  (println (print-history-lines (line-seq (java.io.BufferedReader. *in*)))))
