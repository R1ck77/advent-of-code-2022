(require 'day03)
(require 'buttercup)

(describe "Day 3: Rucksack Reorganization"
  (describe "part 1"
    (it "replicates the example"
      (expect (day03/part-1 (advent/read-problem-lines 3 :example))
              :to-be 157 ))
    (it "solves the problem"
      (expect (day03/part-1 (advent/read-problem-lines 3 :problem))
              :to-be 8493)))
  (xdescribe "part 2"
    (it "replicates the example"
      (expect (day03/part-2 (advent/read-problem-lines 3 :example))
              :to-be 42))
    (xit "solves the problem"
      (expect (day03/part-2 (advent/read-problem-lines 3 :problem))
              :to-be 42))))
