;; 4. red-prob4

(define (problem red-prob4)
  (:domain red)
  (:objects red granny redhouse grannyhouse flower wolf woods)
  (:init (at red woods) (at wolf woods) (at flower woods) (at granny grannyhouse)
         (know-path red)
         (alive granny) (alive red) (alive wolf)
         (pickable flower)
         (ispredator wolf)
         )
  (:goal (and (know-path wolf) (have red flower)(at wolf grannyhouse)(not(alive granny))
              (at red grannyhouse)(not(alive red)))
              ))