8. UNION ALL
여태까지 회사에 입사했던 사람들의 총 인원 수와 연도별 입사한 직원 수를 출력하시오.

<정답 쿼리>
SELECT '총 인원 수 :' AS 입사년도, COUNT(tem1.*) AS 입사한_직원_수 --------- ①
FROM tEmployee AS tem1
UNION ALL ------------ ②
SELECT TO_CHAR(tem2.StartDate,'YYYY'), COUNT(tem2.*) ---------- ③
FROM tEmployee AS tem2
GROUP BY TO_CHAR(tem2.StartDate,'YYYY') ----------------------------- ④
<해설>
① 총 직원수를 출력하기 위해 직원테이블인 tEmployee에서 개수를 구하기 위해 COUNT함수를 사용한다.
② 위의 쿼리와 아래의 쿼리를 UNION ALL을 사용하여 중복된 값도 출력되게 합친다.
③ 입사년도를 출력하기 위해 직원테이블인 tEmployee에서 입사일 컬럼인 StartDate를 가져오고
 TO_CHAR함수를 사용하여 연 형태로 형식을 변경한다.
 직원수를 구하기 위해 직원테이블인 tEmployee에서 개수를 구하기 위해 COUNT함수를 사용한다.
④ TO_CHAR함수를 사용하여 연 형태로 형식을 변경한 StartDate를 GROUP BY를 사용하여 그룹화하여 ①에서
COUNT함수를 사용하여 입사한 총 직원 수를 구한다
<함수설명>
COUNT(tem1.*)
- tem1.* 의 값이 NULL인 값을 제외한 데이터의 개수를 리턴한다.
TO_CHAR(tem2.StartDate,'YYYY')
- 첫번째 파라미터인 StartDate는 Timestamp타입이고, 두번째 파라미터인 ‘YYYY’ 포맷에 맞춰 ‘연도’의 텍스트타입으로 리턴한다.

<풀이 쿼리>
select *
  from temployee;
    
select '총 인원 수' as 연도
     , count(*) as 입사한_직원_수
  from temployee

 union all
 
select temp_startdate as 연도
     , count(*) as 입사한_직원_수
  from (
            select to_char(e1.startdate, 'YYYY') as temp_startdate
              from temployee e1
        ) t1
 group by temp_startdate;