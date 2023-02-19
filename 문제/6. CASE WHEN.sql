6. CASE WHEN
판매 가능한 제품들의 재고 파악을 위해 2020년 2월에 생산된 양을 확인하려하는데 우선 문구류 제품들을 먼저 파악하려 한다. 해당 제품명과 제품들의 총 생산량을 출력하시오.
(문구류의 제품코드(INumber)는 I100(1~5)이며 1번은 가위, 2번은 풀, 3번은 공책, 4번은 볼펜, 5번은 지우개이다, ex - I1001 = 가위)

<정답 쿼리>
SELECT ------------- ①
 CASE
 WHEN tpr.INumber = 'I1001' THEN '가위'
 WHEN tpr.INumber = 'I1002' THEN '풀'
 WHEN tpr.INumber = 'I1003' THEN '공책'
 WHEN tpr.INumber = 'I1004' THEN '볼펜'
 WHEN tpr.INumber = 'I1005' THEN '지우개'
 END AS 제품명
 , SUM(tpr.PCount) AS 총_생산량
FROM tProduction AS tpr
WHERE TO_CHAR(tpr.PDate,'YYYYMM') = '202002' ------------- ②
 AND SUBSTRING(tpr.INumber, 1, 2) = 'I1'
GROUP BY tpr.INumber ------------- ③
<해설>
① 제품명을 출력하기 위해 생산테이블인 tProduction에서 제품코드 컬럼인 INumber을 가져오고
문제의 조건인 제품코드를 기준으로 제품명을 출력하기 위해 제품코드를 기준으로 CASE-WHEN 함수를
사용한다.
 총 생산량을 출력하기 위해 생산테이블인 tProduction에서 생산량 컬럼인 PCount를 가져온다.
합을 구하기 위해 SUM함수를 사용한다.
② 문제의 조건인 2020-02과 같은 값을 가져오기 위해 생산테이블인 tProduction에서 관련 컬럼인
PDate와 비교한다.
 문제의 조건인 문구류와 같은값을 가져오기 위해 SUBSTRING함수를 이용하여 앞 두 자리를 잘라
생산테이블인 tProduction에서 관련 컬럼인 INumber(제품코드)와 비교한다
③ INumber(제품코드)를 GROUP BY를 사용하여 그룹화 한다.
그룹화 한 PCount(생산량)를 기준으로 ①에서 SUM 함수를 사용하여 총 생산량을 구한다.
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다
TO_CHAR( tpr.PDate,'YYYYMM' )
- 첫번째 파라미터인 PDate 는 Timestamp타입이고, 두번째 파라미터인 ‘YYYYMM’ 포맷에 맞춰 ‘연월’의
텍스트타입으로 리턴한다.
SUBSTRING( tpr.INumber, 1, 2 )
- 첫번째 파라미터는 문자열이고 두번째 파라미터는 시작 인덱스입니다. 세번째 파라미터는 가져 올 개수입니다.
INumber에서 1번째부터 2개까지 문자를 가져옵니다.

<풀이 쿼리>
select *
  from titem;

select *
  from tproduction;
  
select case when t1.inumber = 'I1001' then '가위'
            when t1.inumber = 'I1002' then '풀'
            when t1.inumber = 'I1002' then '공책'
            when t1.inumber = 'I1003' then '볼펜'
            when t1.inumber = 'I1004' then '지우개'
        end as 제품명 
     , t1.sum_pcount as 총_생산량
  from (
            select p1.inumber 
                 , sum(p1.pcount) as sum_pcount
              from tproduction p1
             where p1.pdate between cast('20200201' as timestamp)
                                and cast('20200301' as timestamp)
               and p1.inumber in ('I1001', 'I1002', 'I1003', 'I1004', 'I1005')
             group by p1.inumber
        ) t1;
    
select case 
            when p1.inumber = 'I1001' then '가위'
            when p1.inumber = 'I1002' then '풀'
            when p1.inumber = 'I1003' then '공책'
            when p1.inumber = 'I1004' then '볼펜'
            when p1.inumber = 'I1005' then '지우개'
        end 
     , sum(p1.pcount) as sum_pcount
  from tproduction p1
 where p1.pdate between cast('20200201' as timestamp)
                    and cast('20200301' as timestamp)
   and p1.inumber like 'I100%'        
 group by p1.inumber;

             
   