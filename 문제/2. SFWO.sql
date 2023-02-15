2. SFWO
2020년 크리스마스부터 입사일이 만 2년이 넘어가는 사람에게 보너스를 지급하려고 한다.
위 조건에 해당하는 직원의 직원명과 입사일을 출력하시오.
(단, 정렬은 고려하지 않는다)

<정답 쿼리>
SELECT tem.EName AS 직원명, tem.StartDate AS 입사일 -------------- ①
FROM tEmployee AS tem
WHERE tem.StartDate < CAST('2020-12-25' AS TIMESTAMP) - CAST('2 year' AS INTERVAL)---- ②
<해설>
① EName(직원명)을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져오고
StartDate(입사일)을 출력하기 위해 직원테이블인 tEmployee에서 입사일 컬럼인 StartDate를 가져온다.
② 문제의 조건인 2020년 크리스마스(2020-12-25)를 기준으로 입사일이 2년을 넘어간 조건을 찾기 위해 CAST
함수를 사용해서 해당 날짜에서 2년을 뺀 값 보다 작은 값을 직원테이블인 tEmployee에서 관련 컬럼인
StartDate(입사일)와 비교한다.
<함수설명>
cast('2020-12-25'as timestamp)
- 텍스트타입인 ‘2020-12-25’를 timestamp 타입으로 형 변환한다.
cast('2 year' as interval)
- 텍스트타입인 ‘2 year’을 interval 타입으로 형 변환한다.

<풀이 쿼리>
select t2.ename as 직원명
     , t2.startdate as 입사일
  from (
            select t1.ename 
                 , t1.startdate 
              from temployee t1
             where t1.startdate < date '2020-12-25' - interval '2 year'
        ) t2;
  
select date '2020-12-25' - interval '2 year';

select cast('2020-12-25' as timestamp) - cast('2 year' as interval);
