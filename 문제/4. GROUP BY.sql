4. GROUP BY
가구류 제품들의 선호도 조사를 위하여 고객들이 가구류 제품들의 주문을 몇 번 했는지 고객코드별로 출력하시오. (가구류의 생산코드는 P2~로 시작한다)

<정답 쿼리>
SELECT tor.CNumber AS 고객코드 , COUNT(tor.PNumber) AS 제품주문횟수 -------- ①
FROM tOrder AS tor
WHERE SUBSTRING(tor.PNumber,1,2) = 'P2' -------- ②
GROUP BY tor.CNumber -------- ③
<해설>
① CNumber(고객코드)를 출력하기 위해 주문테이블인 tOrder에서 고객코드 컬럼인 CNumber를 가져오고
제품주문횟수를 출력하기 위해 주문테이블인 tOrder에서 생산코드 컬럼인 PNumber를 가져온다.
개수를 구하기 위해 COUNT함수를 사용한다.
② 문제의 조건인 P2와 같은값을 가져오기 위해 SUBSTRING함수를 이용하여 앞 두자리를 잘라
주문테이블인 tOrder에서 관련 컬럼인 PNumber와 비교한다
③ GROUP BY를 사용하여 그룹화 한 CNumber(고객코드)를 기준으로 ①에서 COUNT함수를 사용하여
제품주문횟수를 구한다
<함수설명>
COUNT(tor.PNumber )
- PNumber의 값이 NULL인 값을 제외한 데이터의 개수를 리턴한다
SUBSTRING(tor.PNumber, 1, 2)
- 첫번째 파라미터는 문자열이고 두번째 파라미터는 시작 인덱스입니다. 세번째 파라미터는 가져 올 개수입니다.
PNumber에서 1번째부터 2개까지 문자를 가져옵니다.

<풀이 쿼리>
select *
  from tcustomer;

select *
  from torder;
  
select o1.cnumber as 고객_코드 
     , count(*) as 제품_주문_횟수
  from torder o1
 where o1.pnumber like 'P2%'
 group by o1.cnumber;
 
select o1.cnumber 
     , count(*) 
  from torder o1
 where substring(o1.pnumber, 1, 2) = 'P2'
 group by o1.cnumber;