;; 1. red-prob1

(define (problem red-prob1)
  (:domain red)
  (:objects red granny redhouse grannyhouse wolf woods)
  (:init (at red woods) 
         (at wolf woods)
         (know-path red)
         (alive granny) (alive red) (alive wolf)
         )
  (:goal (and (know-path wolf)
              )))