;; Spring 2014 CSCE 411 Project 
;; Daniel Bartel 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GLOBAL VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Adjacency Matrix: ( ('NODE-NAME (Distances)) )

; RANDOM SEED MAKE SURE THIS IS LOADED IF USING INIT-RANDOM-GRAPH or INIT-RANDOM-EDGE
(defvar *random-state* (make-random-state t))


;; These graphs are for testing purposes


(defvar *example-adj* (list (list 'A '(0 1 1)) (list 'B '(1 0 2)) (list 'C '(1 2 0))))

(defvar *example-med* (list (list 'A '(0 4 2 6))
			    (list 'B '(999 0 999 1))
			    (list 'C '(999 5 0 8))
			    (list 'D '(999 999 999 0))
		      )
)

(defvar *example-hard* (list (list 'A '(0 2 6 999 999 ))
			     (list 'B '(999 0 1 999 1 ))
			     (list 'C '(999 999 0 4 1))
			     (list 'D '(999 2 999 0 999))
			     (list 'E '(999 999 999 999 0))
		       )
)
				   


;; For purposes of project, set maximum weight for an edge to 10, and infinity (for graph init) to 999
(defvar *max-weight* 10)
(defvar *INFINITY* 999)


;;;;;;;;;;;;;;;;;;;;;;;
;;; UTILITY FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;


;; Returns generated adjacency list with `n` nodes
(defun init-random-graph(n)
  (let ( (adj nil) (dist nil))
    (dotimes (i n)
      ; Generate n random distances
      (dotimes (i n)
	(setf dist (cons (+ (random *max-weight*) 1) dist))
      )
      ; Remove self-paths
      (setf (nth i dist) 0)
      (setf adj (append (list (list i dist)) adj))

      ; Reset dist
      (setf dist ())
    )
    (reverse adj)
  )
)
;; Generates graph with random edges
;; Basically, gen random graph filled with edges, then start removing edges until there are e edges left
(defun init-random-edge(v e)
  (let ( (graph (init-random-graph v)) (remove-amt (- (* (- v 1) v) e)) (redge 0) (rvert 0) )
    (dotimes (i remove-amt)
      (setf rvert (random v))
      (setf redge (random v))
      (if (or (= (nth redge (nth 1  (nth rvert graph))) 0) (= (nth redge (nth 1  (nth rvert graph))) 999) )
	  (if (= redge (- v 1)) (setf redge (- redge 1)) (setf redge (+ redge 1)))
      )

      (setf (nth redge (nth 1 (nth rvert graph))) 999)
;      (format t "~a ~%" remove-amt)
    )
    graph
  )


)

;; Pretty Print the adjacency list
(defun pprint-adjacency(matrix)
  (dolist (adj matrix) (format t "~a : ~a~%" (car adj) (nth 1 adj)))
)


;Initialize step is the same for Dijkstra and bellman-ford
;Set the source distance to 0, everything else to infinity
;Set the parent source to source, everything else to nil
; Format: (NODE D[NODE] PARENT[NODE])
(defun init-distances(graph src)
  (let ((paths nil))
    (dolist (n graph)
      (if (equal src (car n)) (setf paths (cons (list (car n) 0 src) paths)) (setf paths (cons (list (car n) *INFINITY* nil) paths)))
    )

    (reverse paths)
  )
)

;gets d[vertice] 
(defun get-distance(distances node)
  (dolist (n distances)
    (if (equal (car n) node) (return-from get-distance (nth 1 n)))
  )
  ; if not found return nil
  nil
)

; get vertice from a graph
(defun get-vertice (graph v)
  (dolist (n graph)
    (if (eq (car n) v) (return-from get-vertice n))
  )
  nil
)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Algorithms
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Dijkstra's Algorithm
(defun dijkstra(graph src)
  (let ( (paths (init-distances graph src)) (Q (init-distances graph src)))
    (loop while (not (eq Q nil))  with active = nil do
      (progn
       ; Pull current shortest distance from queue
	(sort Q #'< :key #'second)
	(setf active (car Q))
	; Relax Edges
	(loop for w in (second (get-vertice graph (car active))) with i = 0 do
	     (progn
	       (if (< (+ w (nth 1 active)) (get-distance paths (car (nth i paths))))
		   (progn
		     (setf (nth 1 (nth i paths)) (+ w (nth 1 active)))
		     (setf (nth 2 (nth i paths)) (car active))
		     (dolist (v Q)
		       (if (eq (car v) (car (nth i paths))) 
			   (progn
			     (setf (nth (position v Q) Q) (nth i paths))
			   )
		       )
		     )       
		   )
	       )
	       (setf i (+ i 1))
	     )
	)
	(setf Q (cdr Q))
      )
    )
    paths
  )

)

; Bellman-Ford Algorithm
(defun bellman-ford(graph src)
  (let ( (paths (init-distances graph src)))
    (dolist (n graph)
      (loop for w in (nth 1 n) with i = 0 do
	   (progn 
	     (if (< (+ w (get-distance paths (car n))) (get-distance paths (car (nth i paths))))
		 (progn (setf (nth 1 (nth i paths)) (+ w (get-distance paths (car n)))) (setf (nth 2 (nth i paths)) (car n))) 
	     )
	     (setf i (+ i 1))
           )
       )

    )
    paths
  )
)


;;;;;;;;;;;;;;;;;;
;; Main Function
;;;;;;;;;;;;;;;;;;

(defun main(&optional v  e)
  (let ((test-vertice nil) (test-edges nil))
    (if (equal v nil) (setf v 500))
    (if (equal e nil) (setf e 400))

    (setf test-vertice (init-random-graph v))
    (setf test-edges (init-random-edge v e))

    (format t ">>>> Test Graph Generated~%")
    (format t "[Vertex Test]~%")
    (format t ">>>> Executing Bellman-Ford~%")
    (time (bellman-ford test-vertice 0))
    (format t ">>>> Executing Dijkstra~%")
    (time (dijkstra test-vertice 0))

    (format t "================================")
    (format t "[Edge Test]~%")
    (format t ">>>> Executing Bellman-Ford~%")
    (time (bellman-ford test-edges 0))
    (format t ">>>> Executing Dijkstra~%")
    (time (dijkstra test-edges 0))	  


    nil
  )
)




