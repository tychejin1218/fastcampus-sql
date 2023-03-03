16. INNER JOIN
현재까지 입사했던 모든 직원들의 직원코드, 부서명, 직원명, 직급명, 입사일, 퇴사일을 출력하시오
(부서와 직급의 경우는 코드가 아닌 부서명과 직급명으로 출력하고 입사일과 퇴사일은 연,월,일만 출력되어야한다)

<정답 쿼리>
SELECT tem.ENumber AS 직원코드, tde.DName AS 부서명, tem.EName AS 직원명, tra.RName AS 직급명 ---①
 , TO_CHAR(tem.Startdate,'YYYY-MM-DD') AS 입사일
 , TO_CHAR(tem.Resignationdate,'YYYY-MM-DD') AS 퇴사일
FROM tEmployee AS tem
JOIN tDepartment AS tde ------- ②
ON tem.DNumber = tde.DNumber
JOIN tRank AS tra ------- ③
ON tem.RNumber = tra.RNumber
<해설>
① ENumber(직원코드)를 출력하기 위해 직원테이블인 tEmployee에서 직원코드 컬럼인 ENumber를 가져오
고 DName(부서명)을 출력하기 위해 부서테이블인 tDepartment에서 부서명 컬럼인 DName을 가져오고
EName(직원명)을 출력하기 위해 직원테이블인 tEmployee에서 직원명 컬럼인 EName을 가져오고
RName(직급명)을 출력하기 위해 직급테이블인 tRank에서 직급명 컬럼인 RName을 가져오고 입사일을
출력하기 위해 직원테이블인 tEmployee에서 입사일 컬럼인 StartDate를 가져오고 퇴사일을 출력하기 위
해 직원테이블인 tEmployee에서 퇴사일 컬럼인 Resignationdate를 가져온다.
TO_CHAR함수를 사용하여 연-월-일 형태로 형식을 변경한다.
② tDepartment(부서) 테이블에 있는 DName(부서명)을 가져오기 위해 tEmployee(직원)테이블의
DNumber(부서코드)와 tDepartment(부서)테이블의 DNumber(부서코드)를 JOIN한다.
③ tRank(직급) 테이블에 있는 RName(직급명)을 가져오기 위해 tEmployee(직원)테이블의
RNumber(직급코드)와 tRank(직급)테이블의 RNumber(직급코드)를 JOIN한다.
<함수설명>
TO_CHAR(tem.StartDate,'YYYY-MM-DD')
- 첫번째 파라미터인 StartDate는 Timestamp타입이고, 두번째 파라미터인 ‘YYYY-MM-DD’ 포맷에 맞춰 ‘연-월-일’의 텍스트타입으로 리턴한다.


<풀이 쿼리>
select *
  from temployee;
         
select *
  from tdepartment;  
  
select *
  from trank;    
  
select e1.enumber as 직원_코드     
     , d1.dname as 부서명
     , e1.ename as 직원명
     , r1.rname as 직급명
     , to_char(e1.startdate, 'YYYY-MM-DD') as 입사일
     , to_char(e1.resignationdate, 'YYYY-MM-DD') as 퇴사일
  from temployee e1
  inner join tdepartment d1
    on e1.dnumber = d1.dnumber 
  inner join trank r1
    on e1.rnumber = r1.rnumber;

select e1.enumber as 직원_코드     
     , d1.dname as 부서명
     , e1.ename as 직원명
     , r1.rname as 직급명
     , to_char(e1.startdate, 'YYYY-MM-DD') as 입사일
     , to_char(e1.resignationdate, 'YYYY-MM-DD') as 퇴사일
  from temployee e1
  left outer join tdepartment d1
    on e1.dnumber = d1.dnumber 
  left outer join trank r1
    on e1.rnumber = r1.rnumber;