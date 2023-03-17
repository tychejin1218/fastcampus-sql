26. INNER JOIN
부서별로 직급이 제일 높은 직원을 확인하려 한다. 이에 해당하는 직원의 부서명과 직급명, 직원명을 출력하시오

<정답 쿼리>
SELECT tBase.DName AS 부서명, tBase.RName AS 직급명, tBase.EName AS 직원명 ----------- ①
FROM
(
 SELECT tde.DName -------------- ②
 , tem.EName
 , tra.RName
 , RANK() OVER(PARTITION BY tem.DNumber ORDER BY tem.RNumber DESC) AS ranknum ------- ③
 FROM tEmployee AS tem
 JOIN tDepartment AS tde ------------- ④
 ON tem.DNumber = tde.DNumber
 JOIN tRank AS tra ------------- ⑤
 ON tem.RNumber = tra.RNumber
 WHERE tem.DNumber IS NOT NULL -------------- ⑥
) AS tBase
WHERE tBase.ranknum = 1 ------------------------- ⑦
<해설>
① 문제에서 제시한 DName(부서명), RName(직급명), EName(직원명)을 서브쿼리 tBase(별칭)에서 가져온다.
② DName(부서명)을 출력하기 위해 부서테이블인 tDepartment에서 부서명 컬럼인 DName을 가져오고
 EName(직원명)을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져오고
 RName(직급명)을 출력하기 위해 직급테이블인 tReturn에서 직급명 컬럼인 RName을 가져온다.
③ 직급코드를 통하여 문제의 조건에 맞는 순위를 출력하기 위해 RANK 함수를 사용하였고
PARTITION BY에 부서코드 컬럼인 DNumber를 사용함으로써 각 부서코드 마다 ORDER BY에 존재하는
RNumber(직급코드)를 정렬하여 순위를 매겨준다.
문제의 조건에 맞는 결과인 직급이 제일 높은 직원을 출력하되 동순위가 두 명이상 일수 있기에 RANK 함
수를 사용하여 순위를 매겨 1위인 직원들을 뽑을 수 있는 조건을 만들었고 PARTITION BY에 부서코드 컬
럼인 DNumber를 사용함으로써 부서 별로 출력해주었으며 ORDER BY에 존재하는 RNumber(직급코드)를
기준으로 하여 순위를 출력해주는데 높은 순으로 출력하기 위해 DESC(내림차 순)하여 순위를 출력해준다
④ tDepartment(부서) 테이블에 있는 DName(부서이름)을 가져오기 위해 tEmployee(직원) 테이블의
DNumber(부서코드)와 tDepartmet(부서) 테이블의 DNumber(부서코드)를 JOIN한다.
⑤ tRank(직급) 테이블에 있는 RName(직급이름)을 가져오기 위해 tEmployee(직원) 테이블의
RNumber(직급코드)와 tRank(직급) 테이블의 RNumber(직급코드)를 JOIN한다.
⑥ 문제의 조건인 부서별 출력을 위해선 부서가 없는 직원은 출력되면 안되므로 tEmployee(직원)테이블의
 관련 컬럼인 DNumber가 NULL이 아닌 값을 가져온다.
⑦ 문제의 조건인 부서별 가장 높은 직원을 출력하기 위해 부서별 1등인 값만 가져온다.

<풀이 쿼리>
select *
  from tdepartment;
  
select *
  from temployee;  
  
select *
  from trank;
  
select t1.dname as 부서명
     , t1.rname as 직급명
     , t1.ename as 직원명
  from (
            select d1.dname 
                 , e1.ename      
                 , r1.rname      
                 , rank() over(partition by d1.dnumber order by r1.rnumber desc) as row_num 
              from tdepartment d1
             inner join temployee e1
                on d1.dnumber = e1.dnumber
             inner join trank r1
                on r1.rnumber = e1.rnumber
) t1
where t1.row_num = 1;
  
   