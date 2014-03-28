
;; Spring 2014 CSC 411 Project 
;; Daniel Bartel 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; GLOBAL VARIABLES
;; Adjacency Matrix: ( ('NODE-NAME (Distances)) )
(defvar *example-adj* (list (list 'A '(0 1 1)) (list 'B '(1 0 2)) (list 'C '(1 2 0))))
(defvar *max-weight* 10)

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

; Concept of relaxing edges is in both algorithms
; (graph with distances) => (distances with paths)
(defun relax-edge (node graph)
  ; Examine outgoing edges
  ; if (edge weight + node distance) < neighbor distance - update neighbor distance 
  (format t "~a~%" node)
  (let ( (node-distance (car node)) (neighbors (nth 2 node)))
;    (dolist (nidst (car node))
;      (if (< 
;    )
    
  )
)

(defun tst ()
;  (dijkstra *example-adj* 'A)
  (bellman-ford *example-adj* 'A)
)

; Performs dijkstra's algorithm on a graph for node src
; Returns ( (NAME PATHCOST (PATH))
(defun dijkstra(graph src)
  (let ( (paths nil) (visited nil) )
    ; Initial - set all distances to infinite
    (dolist (n graph)
      (if (not (equal src (car n))) (setf paths (cons (list (car n) 999) paths)) (setf paths (cons (list (car n) 0) paths)))

    )
      ; Initialize Binary heap
      ;Yjhgrsg


      (loop (unless (equal visited nil))
	 
      )






    ; Main loop:
    ; Pick node with smallest path
    ; Calculate shortest path
    ; Mark as visited

    paths
    
  )
)



; Bellman-Ford Algorithm
(defun bellman-ford(graph src)
  (let (  (paths nil) )
    ; Initialize Distances
    ; (<NODE> (Adjacency)) => (<DISTANCE> <NODE> (Adjacency))
    
    (setf graph (mapcar (lambda (x) (if (equal (car x) src) (cons 0 x) (cons 999 x))) graph))
    ; Relax Edges
    (format t "~a~%" graph)
    (dolist (vertex graph)
      (dolist (edge (nth 2 vertex))
	(if (< (car (nth (position edge graph))) (+ edge (car vertex))) ()) ; if new distance is shorter, change it
      )
    )
;    (mapcar (lambda (x) (relax-edge x graph)) graph)

    

  )



)








