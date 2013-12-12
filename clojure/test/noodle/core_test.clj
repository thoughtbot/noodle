(ns noodle.core-test
  (:require [clojure.test :refer :all]
            [noodle.core :refer :all]))

(deftest parser
  (testing "Parsing a history into a vector of commands"
    (is (= "cd" (parse-history-line "  10 cd foo\n")))))

(deftest counter
  (testing "Returning frequency counts for commands"
    (is (= { "cd" 2 } (counts ["cd" "cd"])))
    (is (= { "rake" 3 "cd" 2 } (counts ["rake" "rake" "rake" "cd" "cd"])))))

(deftest weight-test
  (testing "Returns a map of weighted scores of badness"
    (is (= { "cd" 4 } (weights { "cd" 2 })))))
