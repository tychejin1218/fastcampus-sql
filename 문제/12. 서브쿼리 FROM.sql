12. 서브쿼리 FROM
2021년부터 판매가 시작됨에 따라 지난 1년(20년 1월 1일 ~ 20년 12월 31일) 동안 생산된 제품들의 제품코드와 총 생산량을 생산량이 많은 순으로 확인하려한다. 위의 조건에 맞춰 출력하시오.

<정답 쿼리>
SELECT tBase.INumber AS 제품코드, tBase.PCount AS 총_생산량 ----------- ①
FROM
(
 SELECT tpr.INumber, SUM(tpr.PCount) AS PCount --------- ②
 FROM tProduction AS tpr
 WHERE tpr.PDate BETWEEN CAST('2020-01-01' AS TIMESTAMP) -------- ③
AND CAST('2021-01-01' AS TIMESTAMP)
 GROUP BY tpr.INumber ------------------ ④
) AS tBase
ORDER BY tBase.PCount DESC --------------- ⑤
<해설>
① 서브쿼리로 구한 결과물인 tBase(별칭)에서 INumber(제품코드)와 PCount(생산량)을 가져온다.
② INumber(제품코드)를 출력하기 위해 생산테이블인 tProduction에서 제품코드 컬럼인 INumber를 가져온다. 생산량을 출력하기 위해 생산테이블인 tProduction에서 생산량 컬럼인 PCount를 가져온다. 합을 구하기 위해 SUM함수를 사용한다
③ 문제의 조건인 2020년 1월부터 2020년 12월의 값을 가져오기 위해 BETWEEN과 CAST함수를 사용하여 날짜가 2020-01-01보다 크고 2021-01-01보다 작은 값을 생산테이블인 tProduction에서 관련 컬럼인 PDate(생산일자)와 비교한다
④ INumber(제품코드)를 GROUP BY를 사용하여 그룹화 한다. 그룹화 한 INumber(제품코드)를 기준으로 ①에서 SUM함수를 사용하여 생산량을 구한다
⑤ 정렬 기준인 총 생산량을 내림차 순 정렬을 하기 위해 ORDER BY ~ DESC를 사용한다
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다
CAST('2020-01-01' AS TIMESTAMP), CAST('2021-01-01' AS TIMESTAMP)
- 텍스트타입인 ‘2020-01-01’과 '2021-01-01'을 TIMESTAMP타입으로 형 변환한다.

<풀이 쿼리>
select *
  from tproduction;
  
select p1.inumber 
     , p1.pcount 
  from tproduction p1
 where p1.pdate between cast('20200101' as timestamp)
                    and cast('20210101' as timestamp);
                                
select t1.inumber as 제품_코드
     , t1.sum_pcount as 총_생산량
  from (
            select p1.inumber 
                 , sum(p1.pcount) as sum_pcount
              from tproduction p1
             where p1.pdate between cast('20200101' as timestamp)
                                and cast('20210101' as timestamp)
             group by p1.inumber
        ) t1
 order by t1.sum_pcount desc; 
 
                