3. GROUP BY
생산량 조정을 위해 2020년 2월의 총 생산량을 알려고 한다.
해당 월에 생산된 제품들의 코드와 해당 제품들의 총 생산량을 출력하시오.

<정답 쿼리>
SELECT tpr.INumber AS 제품코드, SUM(tpr.PCount) AS 총_생산량 -------- ①
FROM tProduction AS tpr
WHERE tpr.PDate BETWEEN CAST('2020-02-01' AS TIMESTAMP) AND CAST('2020-03-01' AS TIMESTAMP) ---- ②
GROUP BY tpr.INumber ----------- ③
<해설>
① INumber(제품코드)를 출력하기 위해 생산테이블인 tProduction에서 제품코드 컬럼인 INumber을 가져오고
 총 생산량을 출력하기 위해 생산테이블인 tProduction에서 생산량 컬럼인 PCount를 가져온다.
합을 구하기 위해 SUM함수를 사용한다.
② 문제의 조건인 2020년 2월의 값을 가져오기 위해 BETWEEN과 CAST함수를 사용하여 날짜가 2020-02-
01보다 크고 2020-03-01보다 작은 값을 생산테이블인 tProduction에서 관련 컬럼인 PDate(생산날짜)와
비교한다
③ INumber(제품코드)를 GROUP BY를 사용하여 그룹화 한 후 해당 컬럼을 기준으로 ①에서 SUM함수를
사용하여 총 생산량을 구한다
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다.
CAST('2020-02-01' AS TIMESTAMP), CAST('2020-03-01' AS TIMESTAMP)
- 텍스트타입인 '2020-02-01'과 '2020-03-01'를 TIMESTAMP 타입으로 형 변환한다.

<풀이 쿼리>
select inumber as 제품_코드
     , sum(pcount) as 총_생산량
  from tproduction 
 where pdate >= '20200101'::timestamp
   and pdate <= '20200201'::timestamp
 group by inumber;

select inumber as 제품_코드
     , sum(pcount) as 총_생산량
  from tproduction 
 where pdate >= cast('20200101' as timestamp)
   and pdate <= cast('20200201' as timestamp)
 group by inumber;
 
select inumber as 제품_코드
     , sum(pcount) as 총_생산량
  from tproduction 
 where pdate between '20200101'::timestamp and '20200201'::timestamp
 group by inumber;
  

  
 