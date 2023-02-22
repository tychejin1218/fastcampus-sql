11. 서브쿼리 WHERE
2022년 1월에 반품이 발생한 직원을 확인하여 패널티를 부과하려 한다. 이에 해당하는 직원명을 출력하시오.

<정답 쿼리>
SELECT tem.EName AS 직원명 ------- ①
FROM tEmployee AS tem
WHERE tem.ENumber IN ( -------------②
 SELECT tpr.ENumber --------------- ③
 FROM tProduction AS tpr
 WHERE tpr.PNumber IN (
SELECT tor.PNumber ---④
FROM tOrder AS tor
WHERE tor.ONumber IN (
 SELECT tre.ONumber
 FROM tReturn AS tre ---- ⑤
 WHERE TO_CHAR(tre.RDate,'YYYY-MM') = '2022-01')))
<해설>
① 직원명을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져온다.
② 문제의 조건인 반품이 발생한 직원에 해당하는 값을 가져오기 위해 직원테이블인 tEmployee에서 관련 컬럼인 ENumber(직원코드)와 비교하고 여러 조건을 비교하기 위해 다중행 연산자인 IN을 사용한다.
③ 문제의 조건인 반품이 발생한 주문 내역에 해당하는 값을 가져오기 위해 관련 컬럼인 PNumber(생산코드)와 비교한 후 tpr(별칭) 서브쿼리에서 결과물을 출력한 ENumber(직원코드) 컬럼을 가져온다
④ 문제의 조건인 반품 발생 내역에 해당하는 값을 가져오기 위해 관련 컬럼인 ONumber(주문코드)와 비교한 후 tor(별칭) 서브쿼리에서 결과물을 출력한 PNumber(생산코드) 컬럼을 가져온다
⑤ 문제의 조건인 2022년 1월의 반품 내역에 해당하는 값을 가져오기 위해 반품 테이블인 tReturn에서 관련 컬럼인 RDate(반품일자)를 비교 한 후 tre(별칭) 서브쿼리에서 결과물을 출력한 ONumber(주문코드) 컬럼을 가져온다.
<함수설명>
TO_CHAR(tre.RDate,'YYYY-MM')
- 첫번째 파라미터인 RDate 는 Timestamp 타입이고, 두번째 파라미터인 ‘YYYY-MM’ 포맷에 맞춰 ‘년도-월’의 텍스트타입으로 리턴한다.

<풀이 쿼리>
select *
  from treturn;
  
select *
  from temployee;
  
select *
  from treturn 
 where rdate between cast('20220101' as timestamp)
                 and cast('20220201' as timestamp);  

select (select e1.ename from temployee e1 where e1.enumber = p1.enumber ) as 직원명
  from tproduction p1
 where p1.pnumber in (  select o1.pnumber  
                          from torder o1
                         where o1.onumber in (  select onumber  
                                                  from treturn 
                                                 where rdate between cast('20220101' as timestamp)
                                                                 and cast('20220201' as timestamp)));

select e1.ename
  from temployee e1, tproduction p1, torder o1, treturn r1 
 where 1 = 1 
   and e1.enumber = p1.enumber 
   and o1.pnumber = p1.pnumber 
   and r1.onumber = o1.onumber 
   and r1.rdate between cast('20220101' as timestamp)
                    and cast('20220201' as timestamp);
                                                             
