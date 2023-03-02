15. DENSE_RANK
부서별로 연령의 평균을 파악하기 위해서 각 부서마다 속해있는 직원들의 나이로 출생연도를 알아보려한다.
이를 위해 부서명, 직원명, 출생연도를 출력하되 각 부서의 직원들을 출생연도가 빠른 순으로 순위를 매겨라.
(공동순위는 동일하게 부여하고 그 다음 순위는 공동 순위 다음 번호로 순위가 출력되어야 하며 출생연도는 tEmplyee의 ERRN의 앞 2자리로 비교하여 출력할 수 있다. 
D1001 부서는 문구생산부, D2001은 가구생산부, D3001은 액세서리생산부, D4001은 전자기기생산부, D5001은 음료생산부이다.)

<정답 쿼리>
SELECT
 CASE
 WHEN tem.DNumber = 'D1001' THEN '문구생산부'
 WHEN tem.DNumber = 'D2001' THEN '가구생산부'
 WHEN tem.DNumber = 'D3001' THEN '악세사리생산부'
 WHEN tem.DNumber = 'D4001' THEN '전자기기생산부' --------- ①
 WHEN tem.DNumber = 'D5001' THEN '음료생산부'
 ELSE '부서없음'
 END AS 부서명
 , tem.EName AS 직원명 --------- ②
 , SUBSTRING(tem.ERRN, 1, 2) AS 출생연도
 , DENSE_RANK() OVER(PARTITION BY tem.DNumber ORDER BY SUBSTRING(tem.ERRN, 1, 2)) AS 출생연도_순위------ ③
FROM tEmployee AS tem
<해설>
① 부서명을 출력하기 위해 직원테이블인 tEmployee에서 부서코드 컬럼인 DNumber를 가져온 후에 CASE
WHEN을 이용하여 부서코드마다 부서명을 붙여준다.
② 직원명을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져오고 출생연도를 출
력하기 위해 주민번호 컬럼인 ERRN을 가져온 후에 SUBSTRING 함수를 이용하여 앞 두자리를 끊어준다.
③ 문제의 조건에 맞는 결과인 출생연도가 빠른 순을 출력하되 공동순위가 있을때는 다음 번호로 순위가
되어야 하기에 DENSE_RANK 함수를 쓰고 PARTITION BY에 부서코드 컬럼인 DNumber를 이용함으로써
직원들의 연령을 부서별로 파악할 수 있게 하였고 ORDER BY에 존재하는 SUBSTRING(ERRN, 1, 2) (출생
연도)을 기준으로 하여 순위를 출력해준다.
<함수설명>
SUBSTRING(tem.ERRN, 1, 2)
- 첫번째 파라미터는 문자열이고 두번째 파라미터는 시작 인덱스입니다. 세번째 파라미터는 가져 올 개수입니다.
ERRN에서 1번째부터 2개까지 문자를 가져옵니다.

<풀이 쿼리>
select *
  from temployee;
  
select *
  from tdepartment;
  
select e1.dnumber 
     , e1.ename
     , e1.errn 
  from temployee e1;  
  
select t1.dname as 부서명
     , t1.ename as 직원명
     , t1.errn as 출생연도
     , dense_rank () over (partition by t1.dnumber order by t1.errn)
  from (
            select e1.dnumber 
                 , d1.dname 
                 , e1.ename
                 , substring(e1.errn, 1, 2) as errn
              from temployee e1, tdepartment d1
             where e1.dnumber = d1.dnumber 
        ) t1;
  
select coalesce(nullif(t1.dname, ''), '부서없음') as 부서명
     , t1.ename as 직원명
     , t1.errn as 출생연도
     , dense_rank () over (partition by t1.dnumber order by t1.errn)
  from (
            select e1.dnumber 
                 , d1.dname 
                 , e1.ename
                 , substring(e1.errn, 1, 2) as errn
              from temployee e1
              left outer join tdepartment d1
                on e1.dnumber = d1.dnumber 
        ) t1;    