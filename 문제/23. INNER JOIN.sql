20. INNER JOIN
부서별로 생산하는 제품들의 총 생산량을 부서명과 함께 순위를 매겨서 출력하세요
(부서명, 부서에서 생산하는 제품의 총 생산량, 순위가 나와야 하며 공동순위(ex 공동 1등)가 있어도 다음 순위는 순차적으로 매겨진다.)

<정답 쿼리>
SELECT tde.DName AS 부서명 -----①
 , SUM(tpr.PCount) AS 총_생산량
 , ROW_NUMBER() OVER (ORDER BY SUM(tpr.PCount) DESC) AS 총_생산량_순위-------②
FROM tProduction AS tpr
JOIN tEmployee AS tem -----③
ON tpr.ENumber = tem.ENumber
JOIN tDepartment AS tde -----④
ON tem.DNumber = tde.DNumber
GROUP BY tde.DName -----------------------⑤
<해설>
① 부서명을 출력하기 위해 부서테이블인 tDepartment에서 부서명 컬럼인 DName을 가져오고 부서별 총
생산량을 출력하기 위해 생산테이블인 tProduction에서 PCount(생산량)를 가져온 다음 합을 구하기 위해
SUM함수를 사용한다.
② 문제의 조건에 맞는 결과인 제품들의 총 생산량을 출력하되 순위가 겹치면 안 되기 때문에
ROW_NUMBER를 사용하여 순위를 매겼고 ORDER BY에 존재하는 SUM(PCount) (총 판매량)을 기준으로
하여 순위를 출력해주되 생산량이 많은 순으로 출력하기 위해 DESC(내림차 순)으로 출력해준다.
③ tEmployee(직원) 테이블에 있는 ENumber(직원코드)를 가져오기 위해 tEmployee(직원) 테이블의
ENumber (직원코드)와 tProduction (생산)테이블의 ENumber (직원코드)를 JOIN한다.
④ tDepartment(부서) 테이블에 있는 DName(부서명)을 가져오기 위해 tEmployee(직원) 테이블의 DNumber
(부서코드)와 tDepartment(부서) 테이블의 DNumber (부서코드)를 JOIN한다.
⑤ 그룹화 한 DName(부서명)을 기준으로 ①에서 SUM함수를 사용하여 총 생산량을 구한다
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다

<풀이 쿼리>
select *
  from tdepartment;
  
select *
  from temployee;

select t1.dname as 부서명
     , t1.sum_pcount as 총_생산량
     , row_number () over (order by t1.sum_pcount desc) as 순위
  from (
            select d1.dname 
                 , sum(p1.pcount) as sum_pcount
              from tdepartment d1
             inner join temployee e1
                on e1.dnumber = d1.dnumber
             inner join tproduction p1
                on p1.enumber = e1.enumber 
             group by d1.dname 
        ) t1
