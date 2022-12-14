(require 'day08)
(require 'buttercup)

(describe "--- Day 8: Treetop Tree House ---"
  (describe "part 1"
    (it "replicates the example"
      (expect (day08/part-1 (advent/read-grid 8 :example))
              :to-be 21))
    (it "solves the problem"
      (expect (day08/part-1 (advent/read-grid 8 :problem))
              :to-be 1681)))
  (describe "part 2"
    (it "replicates the example"
      (expect (day08/part-2 (advent/read-grid 8 :example))
              :to-be 8))
    (it "solves the problem"
      (expect (day08/part-2 (advent/read-grid 8 :problem))
              :to-be 201684))))
