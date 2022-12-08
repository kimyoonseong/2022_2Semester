;; problem file: 1. Blocksword.pddl

(define (problem 1blocksword)
    (:domain blocksworld)
    (:objects a b c d e f)
    (:init (on-table a) (on-table d)  (on-table f)
           (clear c) (clear e) (clear f)
           (on c b)(on b a) (on e d)(arm-empty))
    (:goal (and (on d c) (on c f) ( on e a) (on-table b))))