5. GROUP BY, HAVING
2020년 1월의 성실직원을 뽑기 위해 성실직원의 기준인 생산량 500개 이상을 달성한 인원들의 직원코드와 총 생산량을 출력하시오.

<정답 쿼리>
SELECT tpr.ENumber AS 직원코드, SUM(tpr.PCount) AS 총_생산량 -------- ①
FROM tProduction AS tpr
WHERE tpr.PDate BETWEEN CAST('2020-01-01' AS TIMESTAMP) AND CAST('2020-02-01' AS TIMESTAMP) --- ②
GROUP BY tpr.ENumber -------- ③
HAVING SUM(tpr.PCount) >= 500 ------------ ④
<해설>
① ENumber(직원코드)를 출력하기 위해 직원테이블인 tEmployee에서 직원코드 컬럼인 ENumber를 가져온
후 총 생산량을 출력하기 위해 생산테이블인 tProduction에서 생산량 컬럼인 PCount를 가져오고 합을
구하기 위해 SUM함수를 사용한다.
② 문제의 조건인 2020년 1월의 값을 가져오기 위해 BETWEEN과 CAST함수를 사용하여 날짜가 2020-01-
01보다 크고 2020-02-01보다 작은 값을 생산테이블인 tProduction에서 관련 컬럼인 PDate(생산일자)와
비교한다
③ PCount(생산량)를 GROUP BY를 사용하여 그룹화 한다.
그룹화 한 PCount(생산량)를 기준으로 ①에서 SUM함수를 사용하여 총 생산량을 구한다.
④ 문제의 조건인 500보다 크거나 같은 값을 집계함수인 SUM의 결과값에 조건을 걸기 위해서 HAVING을
사용한다.
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다
CAST('2020-01-01' AS TIMESTAMP), CAST('2020-02-01' AS TIMESTAMP)
- 텍스트타입인 '2020-01-01'과 '2020-02-01'를 TIMESTAMP 타입으로 형 변환한다.

<풀이 쿼리>
select *
  from tproduction;
  
select t1.enumber as 직원_코드
     , t1.sum_pcount as 총_생산량
  from (
            select p1.enumber
                 , sum(p1.pcount) as sum_pcount
              from tproduction p1
             where pdate between cast('20200101' as timestamp) 
                             and cast('20200201' as timestamp)   
             group by p1.enumber
        ) t1
 where t1.sum_pcount >= 500;    
 
select p1.enumber
     , sum(p1.pcount) as sum_pcount
  from tproduction p1
 where pdate between cast('20200101' as timestamp) 
                 and cast('20200201' as timestamp)                    
 group by p1.enumber
having sum(p1.pcount) >= 500;
    
  
             
             