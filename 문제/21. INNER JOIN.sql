21. INNER JOIN
우리 회사의 고객인 ‘오랜문방구’의 반품제품명, 주문코드, 주문량, 반품량, 반품사유를 출력하세요

<정답 쿼리>
SELECT tit.IName AS 반품제품명, tre.ONumber AS 주문코드, ----①
tpr.PCount AS 주문량, tre.RCount AS 반품량, trr.RReason AS 반품사유
FROM tReturn AS tre
JOIN tOrder AS tor ------②
ON tre.ONumber = tor.ONumber
JOIN tCustomer AS tcu ------③
ON tor.CNumber = tcu.CNumber
JOIN tReturnReason AS trr ------④
ON tre.RRNumber = trr.RRNumber
JOIN tProduction AS tpr ------⑤
ON tor.PNumber = tpr.PNumber
JOIN tItem AS tit ------⑥
ON tpr.INumber = tit.INumber
WHERE tcu.CName = '오랜문방구' ------⑦
<해설>
① 제품명을 출력하기 위해 제품테이블인 tItem에서 제품명 컬럼인 IName을 가져오고 주문코드를 출력하
기 위해 주문테이블인 tOrder 에서 주문코드 컬럼인 ONumber를 주문량을 출력하기 위해 생산테이블인
tProduction에서 생산 및 주문량 컬럼인 PCount, 반품량을 출력하기 위해 반품테이블인 tReturn에서 반
품량 컬럼인 RCount와 마지막으로 반품사유를 출력하기 위해 반품사유테이블인 tReturnReason에서 반
품사유 컬럼인 RReason을 가져온다.
② tOrder(주문) 테이블을 통해서 tReturn(반품) 테이블의 RCount(반품량) 데이터를 가져오기 위하여
tOrder(주문) 테이블의 PNumber(생산코드)와 tProduction(생산) 테이블의 PNumber(생산코드)를 JOIN한다
③ tCustomer(고객) 테이블에 있는 CName(고객명) 데이터를 가져오기 위해 tCustomer(고객) 테이블의
CNumber(고객코드)와 tOrder(주문)테이블의 CNumber(고객코드)를 JOIN한다
④ tReturnReason(반품사유) 테이블에 있는 RReason (반품사유) 데이터를 가져오기 위해 tReturnReason(반
품사유) 테이블의 RRNumber(반품사유코드)와 tReturn (주문)테이블의 RRNumber(반품사유코드)를 JOIN한다
⑤ tProduction(생산) 테이블에 있는 PCount(생산량) 데이터를 가져오기 위해 tProduction(생산) 테이블의
PNumber(생산코드)와 tOrder(주문)테이블의 PNumber(생산코드)를 JOIN한다
⑥ tItem(제품) 테이블에 있는 IName(제품명) 데이터를 가져오기 위해 tItem(제품) 테이블의 INumber(제품코
드)와 tProduction(생산) 테이블의 INumber(제품코드)를 JOIN한다
⑦ 고객테이블인 tCustomer에서 관련 컬럼인 CName과 비교한다.

<풀이 쿼리>
select *
  from tcustomer;

select *
  from torder;
  
select *
  from treturn; 
  
select i1.iname as 반품_제품명
     , o1.onumber as 주문_코드
     , p1.pcount as 주문량
     , r1.rcount as 반품량 
     , r2.rreason as 반품_사유
  from tcustomer c1
 inner join torder o1 
    on o1.cnumber = c1.cnumber 
 inner join tproduction p1
    on p1.pnumber = o1.pnumber 
 inner join titem i1
    on i1.inumber = p1.inumber 
 inner join treturn r1
    on r1.onumber = o1.onumber 
 inner join treturnreason r2
    on r2.rrnumber = r1.rrnumber 
 where cname = '오랜문방구';