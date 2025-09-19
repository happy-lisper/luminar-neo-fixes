(use 'clojure.data)
(require '[clojure.java.jdbc :refer :all])
(require '[clojure.pprint :as pp] '[clojure.java.io :as io])
(defn ppfile [fn s] (with-open [writer (io/writer fn)] (pp/pprint s writer)))
(def tbls [["images" "_id_int_64"] ["paths_images" "_key_id_int_64"] ["paths" "_id_int_64"]]) (defn tbl-cont [db [tn in]] {tn (set (query db [(str "select * from " tn " order by " in)]))})  (defn tbls-cont[db] (->> tbls (map (partial tbl-cont db)) merge)) (defn ppfile [fn s] (with-open [writer (io/writer fn)] (pp/pprint s writer))) '000


(def d1 "../LNC.luminarneo.1") (def d2 "../LNC.luminarneo.2") 's1
(def dbs1 {:classname   "org.sqlite.JDBC" :subprotocol "sqlite" :subname d1}) (def dbs2 {:classname   "org.sqlite.JDBC" :subprotocol "sqlite" :subname d2}) 's2
(def s1 (tbls-cont dbs1)) (def s2 (tbls-cont dbs2)) (def d (diff s1 s2))(ppfile "s1.txt" s1)(ppfile "s2.txt" s2) 's3
