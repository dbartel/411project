
;; Spring 2014 CSC 411 Project 
;; Daniel Bartel 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; GLOBAL VARIABLES
;; Adjacency Matrix: ( ('NODE-NAME (Distances)) )
(defvar *example-adj* (list (list 'A '(0 1 1)) (list 'B '(1 0 2)) (list 'C '(1 2 0))))

(defvar *example-med* (list (list 'A '(0 4 2 6))
			    (list 'B '(999 0 999 1))
			    (list 'C '(999 5 0 8))
			    (list 'D '(999 999 999 0))
		      )
)

(defvar *max-weight* 10)
(defvar *INFINITY* 999)

;;; UTILITY FUNCTIONS

;; Returns generated adjacency list with `n` nodes
(defun init-random-graph(n)
  (let ( (adj nil) (dist nil))
    (dotimes (i n)
      ; Generate n random distances
      (dotimes (i n)
	(setf dist (cons (random *max-weight*) dist))
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


;; Pretty Print the adjacency list
(defun pprint-adjacency(matrix)
  (dolist (adj matrix) (format t "~a : ~a~%" (car adj) (nth 1 adj)))
)

(defun output-stats ()
)

;; "Main" function
(defun compare-algorithms (n)
  (let ( (g (init-random-graph n)) (src nil))
    (setf src (nth (random n) g))
    (bellman-ford g src)
    (dijkstra g src)
  )
)


(defun tst ()
;  (dijkstra *example-adj* 'A)
  (bellman-ford *example-adj* 'A)
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
 


; Performs dijkstra's algorithm on a graph for node src
; Returns ( (NAME PATHCOST (PATH))
(defun dijkstra(graph src)
  ; TODO fix Q init
  (let ( (paths (init-distances graph src)) (Q nil))
    (setf Q paths)
    (loop while (not (eq Q nil))  with active = nil do
      (progn
       ; Pull current shortest distance from queue
	(sort Q #'< :key #'second)
	(setf active (car Q))

	(dolist (n (get-vertice graph (car active)))
	  ; Relax Edges
	)


	(setf Q (cdr Q))

      )
    )


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








