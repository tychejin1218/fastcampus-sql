25. OUTER JOIN
고객별 반품 현황을 파악하기 위하여 고객별로 고객명과 제품을 구매한 양과 반품한 양 그리고 이를 구매량 대비 반품량을 반품률로 나타내시오.
(반품률은 높은 순으로 소숫점 2자리까지 반올림되어 출력되어야하며 반품내역이 없는 값(null)은 0으로 대체 되면서 마지막에 출력되어야 한다.)

<정답 쿼리>
SELECT tcu.CName AS 고객명 --------------- ①
 , SUM(tpr.PCount) AS 구매량
 , COALESCE(SUM(tre.RCount), 0) AS 반품량------ ②
, COALESCE(ROUND(CAST(CAST(SUM(tre.RCount) AS FLOAT)/ ------ ③
CAST(SUM(tpr.PCount) AS FLOAT) * 100 AS DECIMAL),2), 0) AS 반품률
FROM tOrder AS tor
JOIN tCustomer AS tcu ------------------ ④
ON tcu.CNumber = tor.CNumber
JOIN tProduction AS tpr ------------------ ⑤
ON tpr.PNumber = tor.PNumber
LEFT OUTER JOIN tReturn AS tre ------------------ ⑥
ON tre.ONumber = tor.ONumber
GROUP BY tcu.CName ---------------- ⑦
ORDER BY 반품률 DESC NULLS LAST---------------- ⑧
<해설>
① 고객명을 출력하기 위해 고객테이블인 tCustomer에서 고객명 컬럼인 CName을 가져오고 구매량을 출력
하기 위해 주문테이블인 tOrder와 겹쳐지는 생산이력을 가진 값을 생산테이블인 tProduction에서 생산량
컬럼인 PCount를 가져온 다음 합을 구하기 위해 SUM함수를 사용한다.
② 반품량을 출력하기 위해 반품테이블인 tReturn에서 반품량 컬럼인 RCount를 가져오는데 이 때 NULL값
이 있을 수도 있기에 NULL일 때는 0으로 바꿔서 출력하기 위해 COALESCE 함수를 사용한다.
③ 반품률을 출력하기 위해 ①에서 구했던 구매량과 ②에서 구했던 반품량을 나누어주는데 이 때 나누는
값을 FLOAT 형식으로 바꿔주기 위하여 CAST를 사용하고, 소수점 두 자리에서 반올림 해줘야 하기에
ROUND 함수를 사용하고 ②와 마찬가지로 NULL일 때는 0으로 바꿔서 출력하기 위해 COALESCE함수를
사용한다.
④ tCustomer(고객) 테이블에 있는 CName(고객명)을 가져오기 위해 tOrder(주문) 테이블의 CNumber(고객
코드)와 tCustomer(고객)테이블의 CNumber(고객코드)를 JOIN한다.
⑤ tProduction(생산) 테이블에 있는 PCount(생산량)를 가져오기 위해 tOrder(주문) 테이블의 PNumber(생산
코드)와 tProduction(생산) 테이블의 PNumber(생산코드)를 JOIN한다.
⑥ tReturn(반품) 테이블에 있는 RCount (반품량)를 가져오기 위해 tReturn(반품) 테이블의 ONumber(주문코
드)와 tOrder(주문) 테이블의 ONumber(주문코드)를 JOIN하되 반품되지 않은 주문정보까지 출력해주기
위하여 LEFT OUTER JOIN을 사용한다
⑦ 그룹화 한 CName(고객명)을 기준으로 SUM함수를 사용하여 ①, ②에서 SUM(PCount)(구매량)과 반품량
을 구하여 출력하게한다.
⑧ 정렬 기준인 반품률을 내림차순정렬을 하기 위해 ORDER BY 를 사용하고 NULL값이 있다면 마지막에 출
력하기 위하여 NULLS LAST를 사용한다.
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다
COALESCE(SUM(tre.RCount), 0)
- COALESCE 내부의 SUM(RCount) 값이 NULL 일 때 0으로 대체한다.
CAST(SUM(tre.RCount) AS FLOAT), CAST(SUM(tpr.PCount) AS FLOAT)
- NUMERIC 타입인 SUM(tre.RCount)와 SUM(tpr.PCount)의 데이터 타입을 FLOAT 형식으로 바꿔준다.
ROUND(CAST(CAST(SUM(tre.RCount) AS FLOAT) / CAST(SUM(tpr.PCount) AS FLOAT) * 100 AS DECIMAL),2)
- RCount의 모든 데이터를 합친 값과 PCount의 모든 데이터를 합친 값을 FLOAT타입으로 변환하고 100을 곱한
후 DECIMAL타입으로 변환하고 소수점 2자리까지 반올림한다

<풀이 쿼리>
select *
  from tcustomer;
  
select *
  from treturn;
  
select *
  from torder;
  
select *
  from tproduction; 

select t1.cname as 고객명
     , t1.sum_pcount as 구매량
     , t1.sum_rcount as 반품량
     , coalesce(round(100.0 * t1.sum_rcount / t1.sum_pcount, 2), 0) as 반품률
  from (
            select c1.cname 
                 , coalesce(sum(p1.pcount), 0) as sum_pcount         
                 , coalesce(sum(r1.rcount), 0) as sum_rcount
              from tcustomer c1
             inner join torder o1
                on o1.cnumber = c1.cnumber
             inner join tproduction p1
                on p1.pnumber = o1.pnumber
             left outer join treturn r1
                on r1.onumber = o1.onumber 
             group by c1.cname
        ) t1
  order by 반품률 desc nulls last;
     