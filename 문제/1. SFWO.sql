1. SFWO
문구생산부와 가구생산부의 직원정보를 확인하려한다.
위에 해당하는 직원들의 직원명과 입사일을 입사일이 빠른 순서대로 출력하세요.
(문구생산부의 DNumber는 'D1001', 가구생산부는 'D2001'이며 입사일은 연,월,일까지만 출력되어야 한다)

<정답 쿼리>
SELECT tem.EName AS 직원명, TO_CHAR(tem.StartDate,'YYYY-MM-DD') AS 입사일 ----------①
FROM tEmployee AS tem
WHERE tem.DNumber IN ('D1001', 'D2001') ----------②
ORDER BY tem.StartDate ----------③
<해설>
① EName(직원명)을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져오고
StartDate(입사일)을 출력하기 위해 직원테이블인 tEmployee에서 입사일 컬럼인 StartDate를 가져온 후
TO_CHAR함수를 사용하여 연-월-일 형태로 형식을 변경한다.
② 문제의 조건인 'D1001', 'D2001'에 해당하는 값을 가져오기 위해 직원테이블인 tEmployee에서 관련 컬럼
인 DNumber(부서코드)와 비교한 후 여러 조건을 비교하기 위해 다중 행 연산자인 IN을 사용한다.
③ 정렬 기준인 StartDate(입사일)를 오름차 순 정렬을 하기 위해 ORDER BY를 사용한다.
<함수설명>
TO_CHAR(tem.StartDate,'YYYY-MM-DD')
- 첫번째 파라미터인 StartDate는 Timestamp타입이고, 두번째 파라미터인 ‘YYYY-MM-DD’ 포맷에 맞춰 ‘년도-월-일’의 텍스트타입으로 리턴한다.

<풀이 쿼리>
select t2.ename as 직원명
     , to_char(t2.startdate, 'YYYY-MM-DD') as 입사일
  from (
            select t1.ename
                 , t1.startdate 
              from temployee t1
             where dnumber in ('D1001', 'D2001')
        ) t2
 order by t2.startdate asc;
    