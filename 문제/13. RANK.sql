13. RANK
회사 내 우수직원을 생산량이 많은 직원을 기준으로 하여 상위 10명까지 뽑아 상여금을 주려한다.
이에 해당하는 직원들의 직원코드와 총 생산량을 상위 10명까지 순위를 매겨 출력하시오.
(만약 공동순위(ex. 공동 1등)가 있다면 다음 순위는 중복 된 순위의 수 만큼 떨어진다.)

<정답 쿼리>
SELECT tpr.ENumber AS 직원코드 ------- ①
 , SUM(tpr.PCount) AS 총_생산량
 , RANK() OVER(ORDER BY SUM(tpr.PCount) DESC) AS 총_생산량_순위 ---------- ②
FROM tProduction AS tpr
GROUP BY tpr.ENumber -------- ③
LIMIT 10 -------- ④
<해설>
① 직원코드를 출력하기 위해 생산테이블인 tProduction에서 직원코드 컬럼인 ENumber를 가져오고
총 생산량을 출력하기 위해 생산테이블인 tProduction에서 생산량 컬럼인 PCount를 가져온다.
합을 구하기 위해 SUM함수를 사용한다
② 문제의 조건에 맞는 결과인 생산량이 많은 직원을 출력하되 동순위가 두 명이상 일 수 있기에 Rank를
사용하였고 ORDER BY에 존재하는 SUM(PCount) (총 판매량)을 기준으로 생산량이 많은 순으로 출력하기
위해 DESC(내림차 순)하여 순위를 출력해준다
③ 그룹화 한 ENumber(직원코드)를 기준으로 ①에서 SUM함수를 사용하여 총 생산량을 구한다
④ 상위 10명까지 출력을 해 주어야 하기 때문에 LIMIT 10을 사용해준다.
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다.
LIMIT 10
- LIMIT로 정한 수인 10 만큼 반환하게끔 제한 할 수가 있다

<풀이 쿼리>
select *
  from tproduction;
  
select rank() over (order by t1.sum_pcount desc) as 순위
     , t1.enumber as 직원_코드 
     , t1.sum_pcount as 총_생산량
  from (
            select p1.enumber 
                 , sum(p1.pcount) as sum_pcount 
              from tproduction p1
             group by p1.enumber
        ) t1
 limit 10;                 
 