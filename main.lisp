;; Copyright © 2022  Hraban Luyat
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU Affero General Public License as published
;; by the Free Software Foundation, version 3 of the License.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU Affero General Public License for more details.
;;
;; You should have received a copy of the GNU Affero General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

(uiop:define-package #:leetcode-1657
  (:nicknames #:leetcode-1657/main)
  (:use #:cl #:arrow-macros)
  (:import-from #:fset #:bag #:convert)
  (:export #:main))

(in-package #:leetcode-1657/main)

(defun counts (b)
  "Get a multi-set containing only the /counts/ of bag B."
  (->> b
       (convert 'fset:map)
       (convert 'list)
       (mapcar #'cdr)
       (convert 'bag)))

(defun normalize (w)
  (let* ((b (convert 'bag w))
         (s (convert 'fset:set b))
         (c (counts b)))
    (cons s c)))

(defun main-aux (word1 word2)
  (let ((res (fset:equal? (normalize word1)
                          (normalize word2))))
    (format T "~:[false~;true~]~%" res)))

(defun main ()
  (apply #'main-aux (uiop:command-line-arguments)))
