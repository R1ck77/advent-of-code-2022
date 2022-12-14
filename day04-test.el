(require 'day04)
(require 'buttercup)

(describe "--- Day 4: Camp Cleanup ---"
  (describe "part 1"
    (it "replicates the example"
      (expect (day04/part-1 (advent/read-problem-lines 4 :example))
              :to-be 2))
    (it "solves the problem"
      (expect (day04/part-1 (advent/read-problem-lines 4 :problem))
              :to-be 588)))
  (describe "part 2"
    (it "replicates the example"
      (expect (day04/part-2 (advent/read-problem-lines 4 :example))
              :to-be 4))
    (it "solves the problem"
      (expect (day04/part-2 (advent/read-problem-lines 4 :problem))
              :to-be 911))))
