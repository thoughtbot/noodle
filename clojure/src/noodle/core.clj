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

(defn print-one
  [[command weight]]
  (format "%s: %d\n" command weight))

(defn pretty-print
  [m]
  (clojure.string/join (map print-one m)))

(defn sort-by-weight
  [m]
  (into (sorted-map-by (fn [key1 key2]
                         (compare [(get m key2) key2]
                                  [(get m key1) key1])))
        m))

(defn run
  [in]
  (println (pretty-print 
             (sort-by-weight 
               (weights 
                 (counts (map parse-history-line (line-seq in))))))))

(defn main
  []
  (run (java.io.BufferedReader. *in*)))
