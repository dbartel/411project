;; Spring 2014 CSC 411 Project 
;; Daniel Bartel 

;; Adjacency Matrix: ( ('NODE-NAME (Distances)) )
(defvar *example-adj* (list (list 'A '(0 1 1)) (list 'B '(1 0 2)) (list 'C '(1 2 0))))
n
; Returns generated adjacency list with `n` nodes
(defun init-random-graph(n)

)

; Performs dijkstra's algorithm on a graph for node src
(defun dijkstra(graph src)
)



(defun bellman-ford(graph src)
)

(defun compare-algorithms (n)
  (let ( (g init-random-graph(n)) (src nil))
    (setf src (nth (random n) g))
    (bellman-ford g src)
    (dijkstra g src)
  )
)


(defun output-stats ()
)

(defun pprint-adjacency(matrix)
  (dolist (adj matrix) (format t "~a~%" adj))
)

