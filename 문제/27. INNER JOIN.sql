27. INNER JOIN
입사일이 10년이 넘는 직원들에게는 해당 직원들의 평균판매량을 기준으로 추가수당을 주려한다.
2022년 2월 28일을 기준으로 해당 직원들의 평균 판매 금액을 출력하시오.
(반품 내역은 고려하지 않지만 퇴사자는 제외되어야 한다.)

<정답 쿼리>
SELECT AVG(tBase.sell_SUM) AS 평균판매금액 ------------------ ①
FROM
(
 SELECT SUM(tpr.PCount*tit.Price) AS sell_SUM -------------- ②
 FROM tOrder AS tor
 JOIN tProduction AS tpr ------------------ ③
 ON tpr.PNumber = tor.PNumber
 JOIN tItem AS tit ----------------- ④
 ON tit.INumber = tpr.INumber
 JOIN tEmployee tem ----------------- ⑤
 ON tem.ENumber = tpr.ENumber
 WHERE tem.StartDate < CAST('2022-02-28' AS TIMESTAMP) – CAST('10 year' AS INTERVAL) -----⑥
 AND tem.ResignationDate IS NULL
 GROUP BY tem.EName ---------- ⑦
) AS tBase
<해설>
① tBase(별칭) 서브쿼리에서 결과물을 출력한 sell_SUM(총 판매금액) 컬럼을 가져와 평균을 나타내기 위하여
집계함수 AVG를 사용한다.
② 총 판매 금액을 출력하기 위해 판매량과 단가를 곱한 후 GROUP BY를 기준으로 SUM을 사용하여 합하였
는데 이 때 사용한 판매량을 출력하기 위해 주문테이블인 tOrder 와 겹쳐지는 생산이력을 가진 값을 생
산테이블인 tProduction에서 생산량 컬럼인 PCount를 가져왔고 단가를 출력하기 위해 제품테이블인
tItem에서 단가 컬럼인 Price를 가져온다.
③ tProduction(생산) 테이블에 있는 PCount(생산량)을 가져오기 위해 tProduction(생산) 테이블의
PNumber(생산코드)와 tOrder(주문) 테이블의 PNumber(생산코드)를 JOIN한다.
④ tItem(제품) 테이블에 있는 Price(단가)를 가져오기 위해 tItem(제품) 테이블의 INumber(제품코드)와
tProduction(생산) 테이블의 INumber(제품코드)를 JOIN한다.
⑤ tEmployee(직원) 테이블에 있는 StartDate(입사일)를 가져오기 위해 tEmployee(직원) 테이블의 ENumber
(직원코드)와 tProduction(생산) 테이블의 ENumber (직원코드)를 JOIN한다.
⑥ 문제의 조건인 2022-02-28을 기준으로 입사일이 10년 넘어간 조건을 가져오기 위해 CAST 함수를 사용하
여 해당 날짜에서 10년을 뺀 값 보다 작은 값을 직원테이블인 tEmployee에서 관련 컬럼인 StartDate와
비교하였고 퇴사자는 제외되어야 하기 때문에 같은 테이블의 퇴사일자 컬럼인 ResignationDate을 비교하
여 NULL인 값을 가져온다.
⑦ 그룹화 한 EName(직원명)을 기준으로 ②에서 SUM함수를 사용하여 총 판매량을 구하였다.
<함수설명>
AVG(tBase.sell_SUM)
- sell_SUM의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값의 평균을 계산 한 후 계산된 값을 리턴.
SUM(tpr.PCount*tit.Price)
- (tpr.PCount * tit.Price) 의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다.
CAST('2022-02-28' AS TIMESTAMP)
- 텍트스타입인 ‘2022-02-28’을 TIMESTAMP 타입으로 형 변환한다.
CAST('10 year' AS INTERVAL)
- 텍스트타입인 10 year을 INTERVAL타입으로 형 변환한다.

<풀이 쿼리>
select *
  from temployee;  
  
select *
  from tproduction;
  
select *
  from torder;
  
select avg(t1.sum_price) as 평균_판매_금액
  from (
            select sum(p1.pcount * i1.price) as sum_price
              from tproduction p1
             inner join titem i1
                on i1.inumber = p1.inumber 
             inner join torder o1
                on o1.pnumber = p1.pnumber 
             inner join temployee e1
                on ( e1.enumber = p1.enumber 
                     and e1.startdate < cast('2022-02-28' as timestamp) - cast('10 year' as interval)
                     and resignationdate is null )
            group by e1.ename         
        ) t1;
    
