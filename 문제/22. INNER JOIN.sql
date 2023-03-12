22. INNER JOIN
퇴사자들이 생산한 제품들 중 반품된 제품들의 정보에 대해 알아보려 한다.
해당 조건에 맞는 제품을 생산한 직원명과 제품명, 해당 제품의 생산량, 반품량, 반품이유를 출력하시오.

<정답 쿼리>
SELECT tem.EName AS 직원명, tit.IName AS 제품명, tpr.PCount AS 생산량, ---------- ①
tre.RCount AS 반품량, trr.RReason AS 반품사유명
FROM tEmployee AS tem
JOIN tProduction AS tpr ----------- ②
ON tem.ENumber = tpr.ENumber
JOIN tOrder AS tor ----------- ③
ON tpr.PNumber = tor.PNumber
JOIN tReturn AS tre ------------ ④
ON tor.ONumber = tre.ONumber
JOIN tReturnReason AS trr ------------ ⑤
ON tre.RRNumber = trr.RRNumber
JOIN tItem AS tit ------------- ⑥
ON tpr.INumber = tit.INumber
WHERE tem.Resignationdate IS NOT NULL ------ ⑦
<해설>
① EName(직원명)을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져오고
 IName(제품명)을 출력하기 위해 제품테이블인 tItem에서 제품명 컬럼인 IName을 가져오고
 PCount(생산량)을 출력하기 위해 생산테이블인 tProduction에서 생산량 컬럼인 PCount을 가져오고
 RCount(반품량)을 출력하기 위해 반품테이블인 tReturn에서 반품량 컬럼인 RCount을 가져오고
 RReason(반품사유명)을 출력하기 위해 반품사유테이블인 tReturnReason에서 반품사유명 컬럼인
RReason을 가져온다.
② tEmployee(직원) 테이블에 있는 EName(직원명)을 가져오기 위해 tEmployee(직원) 테이블의
ENumber(직원코드)와 tProduction(생산)테이블의 Eumber(직원코드)를 JOIN한다.
③ tOrder(주문) 테이블에 있는 ONumber(주문코드)를 가져오기 위해 tProduction(생산) 테이블의
PNumber(생산코드)와 tOrder(주문) 테이블의 PNumber(생산코드)를 JOIN한다.
④ tReturn(반품) 테이블에 있는 RCount(반품량)를 가져오기 위해 tOrder(주문) 테이블의
ONumber(주문코드)와 tReturn(반품) 테이블의 ONumber(주문코드)를 JOIN한다.
⑤ tReturnReason(반품사유) 테이블에 있는 RReason(반품사유)를 가져오기 위해 tReturn(반품) 테이블의
RRNumber(반품사유코드)와 tReturnReason(반품사유) 테이블의 RRNumber(반품사유코드)를 JOIN한다.
⑥ tItem(제품) 테이블에 있는 IName(제품명)을 가져오기 위해 tProduction(생산) 테이블의
INumber(제품코드)와 tItem(제품) 테이블의 INumber(제품코드)를 JOIN한다.
⑦ 문제의 조건인 퇴사자를 구하기 위해 직원테이블인 tEmployee에서 관련 컬럼인 Resignationdate(퇴사일
자)가 NULL이 아닌 것을 찾는다


<풀이 쿼리>
select *
  from temployee; 
  
select *
  from tproduction;
  
select *
  from titem;
  
select *
  from treturn;

select e1.ename as 직원명
     , i1.iname as 제품명
     , p1.pcount as 생산량
     , r1.rcount as 반품량
     , r2.rreason as 반품_이유
  from temployee e1
 inner join tproduction p1
    on p1.enumber = e1.enumber 
 inner join titem i1
    on i1.inumber = p1.inumber 
 inner join torder o1
    on o1.pnumber = p1.pnumber 
 inner join treturn r1
    on r1.onumber = o1.onumber 
 inner join treturnreason r2
    on r2.rrnumber = r1.rrnumber 
 where e1.resignationdate is not null;   
  