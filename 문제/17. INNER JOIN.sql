17. INNER JOIN
2021년 1월의 전자기기류 판매금 정산을 위해 전자기기류 제품들의 제품명과 해당 제품의 총 판매량을 출력하세요. (전자기기류의 제품코드는 INumber 번호가 I4로 시작한다.)

<정답 쿼리>
SELECT tit.IName AS 제품명, SUM(tpr.PCount) AS 총_판매량 --------- ①
FROM tOrder AS tor
JOIN tProduction AS tpr ---------- ②
ON tor.PNumber = tpr.PNumber
JOIN tItem AS tit ----------- ③
ON tpr.INumber = tit.INumber
WHERE TO_CHAR(tor.ODate,'YYYY-MM') = '2021-01' AND SUBSTRING(tit.INumber,1,2) = 'I4' --------- ④
GROUP BY tit.IName --------- ⑤
<해설>
① 제품명을 출력하기 위해 제품테이블인 tItem에서 제품명 컬럼인 IName을 가져오고 총 판매량을 출력하
기 위해 제품테이블인 tProduction에서 판매량과 관련된 컬럼인 PCount을 가져온 후 합을 구하기 위해
SUM함수를 사용한다.
② tProduction(생산) 테이블에 있는 PCount(생산량)을 가져오기 위해 tOrder(주문) 테이블의 PNumber (생산
코드)와 tProduction(생산)테이블의 PNumber(생산코드)를 JOIN한다.
③ tItem(제품) 테이블에 있는 IName(제품명)을 가져오기 위해 tProduction(생산) 테이블의 INumber(제품코
드)와 tItem(제품) 테이블의 INumber(제품코드)를 JOIN한다.
④ 문제의 조건인 2021-01과 같은 값을 가져오기 위해 TO_CHAR함수를 이용하여 주문테이블인 tOrder에서
관련 컬럼인 ODate(주문일자)와 비교했고 전자기기류 제품 구분코드인 I4를 출력해주기 위해
SUBSTRING 함수를 이용하여 제품 테이블인 tItem에서 관련 컬럼인 INumber(제품코드)와 비교한다.
⑤ 그룹화 한 IName(제품명)을 기준으로 ①에서 SUM함수를 사용하여 총 판매량을 구한다
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다.
TO_CHAR(tem. ODate,'YYYY-MM')
- 첫번째 파라미터인 StartDate는 Timestamp타입이고, 두번째 파라미터인 ‘YYYY-MM’ 포맷에 맞춰 ‘년도-월’의 텍
스트타입으로 리턴한다.
SUBSTRING( tit.INumber,1,2 )
- 첫번째 파라미터는 문자열이고 두번째 파라미터는 시작 인덱스입니다. 세번째 파라미터는 가져 올 개수입니다.
INumber 에서 1 번째부터 2 개까지 문자를 가져옵니다.


<풀이 쿼리>