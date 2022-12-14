(require 'day19)
(require 'buttercup)

(describe "--- Day 19: Not Enough Minerals ---"
  (xdescribe "part 1"
    (it "replicates the example"
      (expect (day19/part-1 (advent/read-problem-lines 19 :example))
              :to-be 33))
    (it "solves the problem"
      (expect (day19/part-1 (advent/read-problem-lines 19 :problem))
              :to-be 1653)))
  (describe "part 2"
    (it "replicates the example"
      (expect (day19/part-2 (advent/read-problem-lines 19 :example))
              :to-be 3472))
    (it "solves the problem"
      (expect (day19/part-2 (advent/read-problem-lines 19 :problem))
              :to-be 4212))))
