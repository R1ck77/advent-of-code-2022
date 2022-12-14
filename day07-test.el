(require 'day07)
(require 'buttercup)

(describe "--- Day 7: No Space Left On Device ---"
  (describe "part 1"
    (it "replicates the example"
      (expect (day07/part-1 (advent/read-problem-lines 7 :example))
              :to-be 95437 ))
    (it "solves the problem"
      (expect (day07/part-1 (advent/read-problem-lines 7 :problem))
              :to-be 1077191)))
  (describe "part 2"
    (it "replicates the example"
      (expect (day07/part-2 (advent/read-problem-lines 7 :example))
              :to-be 24933642))
    (it "solves the problem"
      (expect (day07/part-2 (advent/read-problem-lines 7 :problem))
              :to-be 5649896))))
