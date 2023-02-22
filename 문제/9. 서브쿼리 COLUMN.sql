10. 서브쿼리 COLUMN
회사에서 제공해주는 기숙사에 머무를 수 있는 인원의 제한을 위해 부서와 직급, 그리고 현재 거주지를 따져 제한하려고 한다. 이에 따라 부서명과 직급명, 직원명 그리고 현재 직원의 주소를 출력하시오
(부서코드, 직급코드가 아닌 부서명, 직급명으로 출력되어야 한다.)

<정답 쿼리>
SELECT (SELECT tde.DName FROM tDepartment AS tde WHERE tde.DNumber = tem.DNumber) AS 부서명----①
 , tem.EName AS 직원명 -------- ②
 , (SELECT tra.RName FROM tRank AS tra WHERE tra.RNumber = tem.RNumber) AS 직급명------------③
 , tem.EAddr AS 직원주소 --------- ④
FROM tEmployee AS tem
<해설>
① tEmployee(직원테이블)에 존재하는 DNumber(부서코드)를 이용하여 DName(부서명)을 출력하기 위해 SELECT절에 서브쿼리를 사용한다.
② EName(직원명)을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져온다.
③ tEmployee(직원테이블)에 존재하는 RNumber(직급코드)를 이용하여 RName(직급명)을 출력하기 위해 SELECT절에 서브쿼리를 사용한다.
④ EAddr(직원주소)를 출력하기 위해 직원테이블인 tEmployee에서 직원주소 컬럼인 EAddr을 가져온다.

<풀이 쿼리>
select *
  from temployee;

select *
  from tdepartment;
  
select *
  from trank;  
  
select (select dname 
          from tdepartment d1
         where e1.dnumber = d1.dnumber) as 부서명
     , (select rname 
          from trank r1
         where e1.rnumber = r1.rnumber) as 직급명
     , e1.ename as 직원명
     , e1.eaddr as 직원의_주소 
  from temployee e1;
  