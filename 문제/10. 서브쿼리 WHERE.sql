10. 서브쿼리 WHERE
회사 내 전 직원들의 평균 생산량보다 한번이라도 많이 생산한 직원들에게는 상여금을 주려한다. 이에 해당하는 직원명을 출력하시오 (생산량은 tProduction 테이블의 PCount이다.)

<정답 쿼리>
SELECT tem.EName AS 직원명 --------- ①
FROM tEmployee AS tem
WHERE tem.ENumber IN ( ------------------ ②
 SELECT tpr1.ENumber ----------- ③
 FROM tProduction AS tpr1
 WHERE tpr1.PCount > ( ------------------ ④
 SELECT AVG(tpr2.PCount) ------------- ⑤
 FROM tProduction AS tpr2
 )
 )
<해설>
① EName(직원명)을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져온다.
② 문제의 조건인 평균 생산량보다 생산량이 많은 직원의 직원명을 찾기 위해 ENumber(직원코드)를 비교한 후 여러 값을 비교하기 위해 다중 행 연산자인 IN을 사용한다.
③ ENumber(직원코드)를 출력하기 위해 생산테이블인 tProduction 에서 직원코드 컬럼인 ENumber를 가져온다.
④ 문제의 조건인 평균 생산량 보다 많은 직원의 직원코드를 찾기위해 생산량을 비교한다.
⑤ PCount(생산량)를 출력하기 위해 직원테이블인 tEmployee에서 생산량 컬럼인 PCount를 가져온다. 
평균을 구하기 위해 AVG함수를 사용한다.
동명이인의 경우가 있을 수 있으므로 고유번호(기본키)인 직원 코드로 비교를 진행한다.
<함수설명>
AVG( tpr2.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 다하고 개수만큼 나누는 계산을 한 후 계산된 값을 리턴.

<풀이 쿼리>
select *
  from temployee;
  
select *
  from tproduction;

select t1.ename
  from (
            select e1.ename 
                 , p1.pcount      
                 , (select avg(pcount) from tproduction) as avg_pcount
              from temployee e1, tproduction p1
             where e1.enumber = p1.enumber
        ) t1
 where t1.pcount > avg_pcount;
 
select e1.ename
  from temployee e1, tproduction p1
 where e1.enumber = p1.enumber 
   and p1.pcount > (select avg(pcount)
                      from tproduction);