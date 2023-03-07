18. INNER JOIN
2020년 1월에 만들어진 모든 제품의 생산코드, 생산직원명, 제품명, 생산량, 생산일자를 출력하세요 (단, 정렬은 고려하지 않는다 )

<정답 쿼리>
SELECT tpr.PNumber AS 생산코드, tem.EName AS 생산직원명, tit.IName AS 제품명, --------- ①
tpr.PCount AS 생산량, tpr.PDate AS 생산일자
FROM tProduction AS tpr
JOIN tItem AS tit --------- ②
ON tpr.INumber = tit.INumber
JOIN tEmployee AS tem ---------- ③
ON tpr.ENumber = tem.ENumber
WHERE TO_CHAR(tpr.PDate,'YYYY-MM') = '2020-01' --------- ④
<해설>
① PNumber(생산코드)를 출력하기 위해 생산테이블인 tProduction에서 생산코드 컬럼인 PNumber을 가져오고
 EName(직원명)을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져오고
 IName(제품명)을 출력하기 위해 제품테이블인 tItem에서 제품명 컬럼인 IName을 가져오고
 PCount(생산량)을 출력하기 위해 생산테이블인 tProduction에서 생산량 컬럼인 PCount를 가져오고
 PDate(생산일자)를 출력하기 위해 생산테이블인 tProduction에서 생산일자 컬럼인 PDate를 가져온다.
② tItem(제품) 테이블에 있는 IName(제품명)을 가져오기 위해 tItem(제품) 테이블의
INumber(제품코드)와 tProduction(생산)테이블의 INumber(제품코드)를 JOIN한다.
③ tEmployee(직원) 테이블에 있는 EName(직원명)을 가져오기 위해 tEmployee(직원) 테이블의
ENumber(직원코드)와 tProduction(생산)테이블의 ENumber(직원코드)를 JOIN한다.
④ 문제의 조건인 2020-01과 같은값을 가져오기 위해 TO_CHAR 함수를 이용하여 생산테이블인 tProduction에
서 관련 컬럼인 PDate와 비교한다
<함수설명>
TO_CHAR(tpr.PDate,'YYYY-MM-DD')
- 첫번째 파라미터인 PDate는 TIMESTAMP타입이고, 두번째 파라미터인 ‘YYYY-MM-DD’ 포맷에 맞춰 ‘연-월-일’의
텍스트타입으로 리턴한다.

<풀이 쿼리>
select *
  from tproduction;
  
select *
  from temployee;
  
select *
  from titem;
  
select p1.pnumber 
     , e1.ename 
     , i1.iname 
     , p1.pcount 
     , p1.pdate
  from tproduction p1
 inner join temployee e1
    on p1.enumber = e1.enumber 
 inner join titem i1
    on p1.inumber = i1.inumber 
 where p1.pdate between cast('20200101' as date)  
                    and cast('20200201' as date);
