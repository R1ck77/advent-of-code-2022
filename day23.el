(require 'dash)
(require 'advent-utils)
(require 's)

(defconst example (advent/read-problem-lines 23 :example))
(defconst problem (advent/read-problem-lines 23 :problem))

(defconst day23/rules (list
                       (list :dest '(-1 . 0) :checks '((-1 . 0) (-1 . 1) (-1 . -1)))
                       (list :dest '(1 . 0) :checks '((1 . 0) (1 . 1) (1 . -1)))
                       (list :dest '(0 . -1) :checks '((0 . -1) (-1 . -1) (1 . -1)))
                       (list :dest '(0. 1) :checks '((0 . 1) (-1 . 1) (1 . 1)))))

(defconst day23/all-neighbors '((-1 . -1) (-1 . 0) (-1 .  1)
                                ( 0 . -1)          ( 0 .  1)
                                ( 1 . -1) ( 1 . 0) ( 1 .  1)))

(defstruct day23-state "Positions of the elves and their internal states"
           elves ; position -> index (row,column)
           rules ); index -> rule

(defun day23/read-problem (lines)
  (let ((grid (advent/lines-to-grid lines (lambda (x) (if (string= x ".") 0 1))))
        (elves (advent/table))
        ;; Not needed at the moment, but I foresee a "next part, each elf choses it's own direction…
        (rules (make-hash-table)))
    (advent/-each-grid grid
      (when (= it-value 1)
        (advent/put elves it-coord (advent/table-size rules))
        ;; All elves propose the same rule for now, so this is unused
        (advent/put rules (advent/table-size rules) 0) 
        ))
    (make-day23-state :elves elves
                      :rules rules)))

(setq e (day23/read-problem example))
(setq p (day23/read-problem problem))

(defmacro day23/update (f value new-value)
  (let ((v (make-symbol "old"))
        (n (make-symbol "new")))
    `(let ((,v ,value)
           (,n ,new-value))
      (setq ,value (if (or (not ,v) (funcall ,f ,n ,v))
                       ,n
                     ,v)))))

(defun day23/get-corners (state)
  "Return the minimum and maximum coordinate for the elves"
  (let ((min-row)
        (min-column)
        (max-row)
        (max-column))
    (advent/-each-hash (day23-state-elves state)
      (day23/update #'< min-row (car it-key))
      (day23/update #'< min-column (cdr it-key))
      (day23/update #'> max-row (car it-key))
      (day23/update #'> max-column (cdr it-key)))
    (list (cons min-row min-column)
          (cons max-row max-column))))

(defun day23/to-buffer (state buffer)
  (let ((elves (day23-state-elves state))
        (pos))
    (seq-let (min max) (day23/get-corners state)
      (let ((rows (- (car max) (car min)))
            (columns (- (cdr max) (cdr min))))
        (with-current-buffer buffer
          (erase-buffer)
          (-dotimes (1+ rows)
            (lambda (row)
              (-dotimes (1+ columns)
                (lambda (column)
                  (insert (if (advent/get elves (cons (+ (car min) row)
                                                      (+ (cdr min) column)))
                              "#"
                            "."))))
              (insert "\n"))))))))

(defun day23/debug-print (state)
  (let ((buffer (get-buffer-create "*day23*")))
    (day23/to-buffer state buffer)
    (display-buffer buffer)
    (sit-for 0.1)))

(defun day23/to-string (state)
  (with-temp-buffer
    (day23/to-buffer state (current-buffer))
    (s-trim (buffer-substring-no-properties (point-min) (point-max)))))

(defun day23/sum-cons (a b)
  (cons (+ (car a) (car b))
        (+ (cdr a) (cdr b))))

(defun day23/all-free? (elves pos displacements)
  (not
   (--first (advent/get elves it)
            (--map (day23/sum-cons pos it) displacements))))

(defun day23/alone-elf? (state pos)
  "Returns t if there are no elves in the adjacent positions"
  (day23/all-free? (day23-state-elves state) pos day23/all-neighbors))

(defun day23/elf-proposal (state pos rules)
  "Return the proposed movement for the elf at pos.

The rules are a circular list with the first valid rule at car"
  (advent/assert (advent/get (day23-state-elves state) pos) "No elf at pos!")
  (let ((elves (day23-state-elves state)))
    (unless (day23/alone-elf? state pos)
      (if-let ((matching-rule (--first (day23/all-free? elves
                                                        pos
                                                        (plist-get it :checks))
                                       (-take 4 rules))))
          (day23/sum-cons (plist-get  matching-rule :dest) pos)))))

(defun day23/plan-elves-moves (state rules)
  "Returns a dictionary of moves for the elves.

Rules is a cyclic list starting with the current rule"
  (let ((moves-planned (advent/table)))
    ;; Find all proposals and count them
    (advent/-each-hash (day23-state-elves state)
        (if-let ((elf-proposal (day23/elf-proposal state it-key rules)))
            (advent/update moves-planned elf-proposal
                        (lambda (key old-value)
                          (if old-value
                              (cons it-key old-value)
                            (list it-key))))))
    (let ((moves))
      (advent/map-hash moves-planned
                       (lambda (move elves)
                         (print (format "Evaluating move %s elves: %s" move elves))
                         (if (= (length elves) 1)
                             (setq moves (cons (list (car elves) move) moves)))))
      moves)))

(defun day23/get-rules (state)
  "Get the cyclic list of the current rules"
  (nthcdr (advent/get (day23-state-rules state) 0) (-cycle day23/rules)))

(defun day23/update-rules (state)
  "Update the counter for every elf"
  (let ((new-rules (make-hash-table)))
    (advent/-each-hash
        (advent/put new-rules it-key (1+ it-value)))
    (make-day23-state :rules new-rules
                      :elves (copy-hash-table (day23-state-elves state)))))

(defun day23/step (state)
  (let ((moves (day23/plan-elves-moves state (day23/get-rules state))))
))


(defun day23/part-1 (lines)
  (error "Not yet implemented"))

(defun day23/part-2 (lines)
  (error "Not yet implemented"))

(provide 'day23)