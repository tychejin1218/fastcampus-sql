20. OUTER JOIN
2020년 1월의 제품 별 생산량의 순위를 확인하기 위하여 제품명과 생산량을 순위를 매겨 출력하시오.
(모든 제품이 출력되어야 하며 공동순위가 있다면 다음 순위는 공동순위의 수 만큼 밀려나고 생산되지 않은 제품은 제일 마지막 순위로 결정되어야 한다)

<정답 쿼리>
SELECT tit.IName AS 제품명, tBase.PCount AS 생산량, -------------- ①
RANK() OVER(ORDER BY tBase.PCount DESC NULLS LAST) AS 생산량_순위
FROM tItem AS tit
LEFT OUTER JOIN ------------------------------- ②
(
 SELECT tpr.INumber, SUM(tpr.PCount) AS PCount ------------ ③
 FROM tProduction AS tpr
WHERE TO_CHAR(tpr.PDate,'YYYYMM') = '202001' ------------ ④
 GROUP BY tpr.INumber ----------- ⑤
) AS tBase
ON tit.INumber = tBase.INumber
<해설>
① tItem(제품)테이블에서 출력된 IName(제품명)을 가져오고 서브쿼리 tBase(별칭)에서 출력된 생산량을
가져온다.
 문제의 조건에 맞는 결과인 제품 별 생산량의 순위를 출력하되 동순위가 두 명이상 일수 있기에 RANK
함수를 사용하였고 ORDER BY에 존재하는 tBase(별칭).PCount (제품 별 생산량)을 기준으로 하여
생산량이 많은 순으로 순위를 출력해야 하기에 DESC(내림차 순)을 써주었으며 NULL 값은 제일
마지막에 출력하기 위하여 NULLS LAST를 작성한다.
② tItem(제품)테이블에 있는 INumber(제품코드)에 대응하는 서브쿼리 tBase(별칭)의 생산량을 가져오기
위해 tItem(제품) 테이블의 INumber(제품코드)와 서브쿼리 tBase(별칭)의 INumber(제품코드)를 JOIN하되
생산되지 않은 제품정보까지 출력해주기 위하여 LEFT OUTER JOIN을 사용한다.
③ INumber(제품코드)와 PCount(생산량)을 출력하기 위해 생산테이블인 tProduction에서 제품코드 컬럼인
INumber와 생산량 컬럼인 PCount를 가져온다.
그리고 생산량의 합을 구하기 위해 PCount에 SUM함수를 사용한다.
④ 문제의 조건인 ‘202001’과 같은값을 가져오기 위해 TO_CHAR함수를 이용하여 생산테이블인
tProduction에서 관련 컬럼인 PDate와 비교한다
⑤ INumber(제품코드)를 GROUP BY를 사용하여 그룹화 한 후 INumber(제품코드)를 기준으로 ③에서
SUM함수를 사용하여 생산량을 구한다
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다
TO_CHAR(tpr.PDate,'YYYY-MM-DD')
- 첫번째 파라미터인 PDate는 Timestamp타입이고, 두번째 파라미터인 ‘YYYY-MM-DD’ 포맷에 맞춰 ‘연-월-일’의
텍스트타입으로 리턴한다.

<풀이 쿼리>
select *
  from tproduction;
  
select *
  from titem;
  
with temp_production as (
    select p1.inumber 
         , sum(p1.pcount) as sum_pcount 
      from tproduction p1
     where pdate between cast('20200101' as date)
                     and cast('20200201' as date)
     group by p1.inumber
)
select i1.iname as 제품명
     , p1.sum_pcount as 생산량
     , rank () over (order by p1.sum_pcount desc nulls last) as 순위
  from titem i1 
  left outer join temp_production p1
    on i1.inumber = p1.inumber;
  
  
select i1.iname as 제품명
     , p1.pcount as 생산량 
     , rank () over (order by p1.pcount desc nulls last) as 순위
  from titem i1
  left outer join tproduction p1
    on (i1.inumber = p1.inumber 
        and p1.pdate between cast('20200101' as date)
                        and cast('20200201' as date));