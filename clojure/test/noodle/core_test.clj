(ns noodle.core-test
  (:require [clojure.test :refer :all]
            [noodle.core :refer :all]))

(deftest parser
  (testing "Parsing a line from zsh_history into a command"
    (is (= "cd" (history-line->command "  10 cd foo\n")))))

(deftest printer
  (testing "Pretty-printing the commands with their weights"
    (is (= "cd: 4 times\nrake: 3 times\nzsh: 1 times\n" (format-history-map { "zsh" 1 "rake" 3 "cd" 4 })))))

(deftest sorter
  (testing "Sorting the results by weight"
    (is (= (vector ["ls" 8] ["rake" 2] ["zsh" 2])
           (sort-by-weight { "rake" 2 "ls" 8 "zsh" 2 })))))

(def history
  ["  130 ls",
   "  131 ls foo/",
   "  131 ls",
   "  131 ls",
   "  131 ls src/",
   "  131 ls",
   "  131 ls",
   "  131 ls",
   "  173 rake",
   "  183 rake",
   "  190 zsh",
   "  191 zsh"])

(deftest format-history-lines-test
  (testing "Formatting the seq of history lines"
    (is (= "ls: 8 times\nrake: 2 times\nzsh: 2 times\n"
            (format-history-lines history)))))
