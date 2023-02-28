14. ROW_NUM
현재 판매하는 제품들 중 장농의 인기가 많아져 판매 가능한 장농의 재고를 확인하기 위하여 장농 생산이력을 전부 출력하되 생산량이 높은순서대로 생산한 직원의 코드와 제품코드, 생산량을 순위를 매겨 출력하시오.
(공동 순위가 나오지 않게 출력 해야 하며 또한 동률일경우 직원코드(ENumber)가 작은 코드가 우선순위를 가지도록 한다, 장농의 제품코드는 I2003번이다)

<정답 쿼리>
SELECT tpr.ENumber AS 직원코드 -------- ①
 , tpr.INumber AS 제품코드
 , tpr.PCount AS 생산량
 , ROW_NUMBER() OVER(PARTITION BY tpr.INumber ------②
ORDER BY tpr.PCount DESC, tpr.ENumber ASC) AS 생산량_순위
FROM tProduction AS tpr
WHERE tpr.INumber = 'I2003' -------------- ③
<해설>
① ENumber(직원코드)를 출력하기 위해 생산테이블인 tProduction에서 직원코드 컬럼인 ENumber를
가져오고 INumber(제품코드)를 출력하기 위해 생산테이블인 tProduction에서 제품코드 컬럼인
INumber를 가져오고 PCount(생산량)를 출력하기 위해 생산테이블인 tProduction에서 생산량 컬럼인
PCount를 가져온다.
② 구해진 생산량을 통하여 순위를 출력하는데 동률일 경우 직원코드가 작은 코드에 우선순위를 두기 위해
ROW_NUMBER를 사용하였고 PARTITION BY에 제품코드 컬럼인 INumber를 사용함으로써 각 제품코드
마다 ORDER BY에 존재하는 PCount(생산량)이 내림차 순, ENumber(직원코드)가 오름차 순 정렬하여
순위를 매겨준다.
③ 문제의 조건인 I2003과 같은값을 가져오기 위해 생산테이블인 tProduction에서 관련 컬럼인
INumber(제품코드)와 비교한다

<풀이 쿼리>
select *
  from tproduction;
