(require 'day12)
(require 'buttercup)

(describe "--- Day 12: Hill Climbing Algorithm ---"
  (describe "part 1"
    (it "replicates the example"
      (expect (day12/part-1 (advent/read-grid 12 :example #'identity))
              :to-be 31 ))
    (it "solves the problem"
      (expect (day12/part-1 (advent/read-grid 12 :problem #'identity))
              :to-be 481)))
  (describe "part 2"
    (it "replicates the example"
      (expect (day12/part-2 (advent/read-grid 12 :example #'identity))
              :to-be 29))
    (it "solves the problem"
      (expect (day12/part-2 (advent/read-grid 12 :problem #'identity))
              :to-be 480))))
