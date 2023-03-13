24. OUTER JOIN
시장조사를 위하여 불량을 제외한 반품내역을 가진 고객들의 주변에 거주하는 직원들의 명단을 출력하시오
(고객들의 주소와 고객명단, 고객 주변에 거주하는 직원명단은 전부 출력되어야 한다)

<정답 쿼리>
SELECT tBase.CAddr AS 고객주소, tBase.CName AS 고객명, tem.EName AS 직원명 ---------- ①
FROM(
 SELECT * -------------------------- ②
 FROM tCustomer AS tcu
 JOIN tOrder AS tor ------------- ③
 ON tcu.CNumber = tor.CNumber
 JOIN tReturn AS tre ------------- ④
 ON tor.ONumber = tre.ONumber
 JOIN tReturnReason AS trr ------------- ⑤
 ON tre.RRNumber = trr.RRNumber
 WHERE trr.RReason <> '불량' ------------------- ⑥
) AS tBase
LEFT OUTER JOIN tEmployee AS tem -------------- ⑦
ON tBase.CAddr = tem.EAddr
<해설>
① 문제에서 제시한 CAddr(고객주소), CName(고객명), EName(직원명)을 서브쿼리 tBase(별칭)에서 가져온다.
② 모든 데이터를 가져오기 위해 *(모든 컬럼 출력) 를 입력한다.
③ tOrder(주문) 테이블에 있는 데이터를 가져오기 위해 tCustomer(고객) 테이블의
CNumber(고객코드)와 tOrder(주문) 테이블의 CNumber(고객코드)를 JOIN한다.
④ tReturn(반품) 테이블에 있는 데이터를 가져오기 위해 tOrder(주문) 테이블의
ONumber(주문코드)와 tOrder(주문) 테이블의 ONumber(주문코드)를 JOIN한다.
⑤ tReturnReason(반품사유) 테이블에 있는 데이터를 가져오기 위해 tReturn(반품) 테이블의
RRNumber(반품사유코드)와 tReturnReason(반품사유) 테이블의 RRNumber(반품사유코드)를 JOIN한다.
페이지 43 / 98
fastcampus 강사 민경우
⑥ 문제의 조건인 불량이 아닌값을 가져오기 위해 반품사유테이블인 tReturnReason에서 관련컬럼인
RReason(반품사유)과 비교한다.
⑦ 서브쿼리 tBase(별칭)에서 조건에 해당하지 않는 정보까지 출력해주기 위하여 LEFT OUTER JOIN을 사용한다

<풀이 쿼리>
