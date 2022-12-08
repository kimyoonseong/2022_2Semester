;; Red Riding Hood story domain

(define (domain red)
  (:requirements :strips)
  (:predicates (at ?p ?loc)                 ; A person (?p) is at a location (?loc)
                (know-path ?p)              ; A person (?p) knows a path (to grannyhouse)
               (pickable ?th)               ; A thing (?th) can be picked up
               (alive ?p)                   ; A prey (?p) is alive
               (have ?p ?th)                ; A person (?p) has a thing (?th)
               (ispredator ?p)              ; A (?p) is predetor
               (isSleep ?p)                 ; A (?p) is sleep
               (eaten ?p ?th)               ;A(?p) is eat (?th) 
               (snoreloud ?p)               ; (?p) is snoreloud
               (isred ?p)                   ;(?p) is red
               (isgranny ?p)                ;(?p) is granny
               (ishuntsman ?p)              ;(?p) is huntsman
               (ischeck ?p)                 ;(?p) checked everything ok 
               (isSaved ?p )                ;(?p) issaved 
               (isDelivered ?p ?whom ?th)  ;(?p) delivered (?th) to (?whom)
               (feelhappy ?p1 ?p2 ?p3))      ;(?p),(?p2),(?p3) are happy
               
  ; Define a person moves from a location to another location
  (:action moveto
    :parameters (?p ?from ?to)
    :precondition (and (at ?p ?from)
                        (know-path ?p ))
    :effect  (and (at ?p ?to) 
                  (not (at ?p ?from))))


    (:action tell-path
    :parameters (?who ?whom ?loc)
    :precondition (and (alive ?who)
                       (at ?who ?loc)
                       (at ?whom ?loc)
                       (know-path ?who))
                    
    :effect  (and (know-path ?whom)))
    
    (:action pick-up
    :parameters (?who ?what ?loc)
    :precondition (and (alive ?who)
                       (at ?who ?loc)
                       (at ?what ?loc)
                       (pickable ?what))
                    
    :effect  (and (have ?who ?what)))
    
    (:action Sleepandsnoreloud
    :parameters (?who ?prey ?loc )
    :precondition (and (alive ?who)
                       (ispredator ?who)
                       (at ?who ?loc)
                       (at ?prey ?loc)
                       (eaten ?who ?prey)
                       (isred ?prey)
                       )
                    
    :effect  (and (isSleep ?who) (snoreloud ?who)))
    
    (:action check
    :parameters (?who ?wolf ?loc)
    :precondition (and (snoreloud ?wolf)
                        (at ?who ?loc)
                        (at ?wolf ?loc))
    :effect  (and (ischeck ?who ))) 
    
    (:action Save
    :parameters (?who ?whom ?wolf ?loc)
    :precondition (and (snoreloud ?wolf)
                        (ischeck ?who)
                        (at ?who ?loc)
                        (at ?whom ?loc)
                        (not(alive ?whom))
                        )
    :effect  (and (isSaved  ?whom ) (not(alive ?wolf)))) 
    
    (:action eat-alive
    :parameters (?predator ?prey ?loc)
    :precondition (and (ispredator ?predator)
                       (at ?predator ?loc)
                       (at ?prey ?loc)
                       (alive ?predator)
                       (alive ?prey))
    :effect  (and (not(alive ?prey))
                    (eaten ?predator ?prey)))    
                    
    (:action eat-together
    :parameters (?p1 ?p2 ?p3 ?th  ?loc)
    :precondition (and (at ?p1 ?loc)
                       (at ?p2 ?loc)
                       (at ?p3 ?loc)
                       (have ?p2 ?th) ;granny has cake
                      )
                       
    :effect  (and (feelhappy ?p1 ?p2 ?p3)
                   ))    
                  
 
  (:action deliver
    :parameters (?who ?whom ?th  ?loc)
    :precondition (and (have ?who ?th)
                       (isgranny ?whom)
                       (isSaved ?who)
                       (isSaved ?whom)
                       (at ?who ?loc)
                       (at ?whom ?loc)
                       )
    :effect  (and (have ?whom ?th) 
                  (not (have ?who ?th))
                  (isDelivered ?who ?whom ?th))))