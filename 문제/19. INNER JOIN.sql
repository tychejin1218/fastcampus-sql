19. INNER JOIN
2022년 3월 20일 기준으로 현재 판매 가능한 공책의 재고량을 구하시오 (반품되어 돌아온 공책의 경우 재판매 하지 않는다.)

<정답 쿼리>
SELECT tBase.IName AS 제품명, (tBase2.PCount - tBase.OCount) AS 재고량----------- ①
FROM
(
SELECT tit.IName, SUM(tpr.PCount) AS OCount ------ ②
 FROM tProduction AS tpr
 JOIN tOrder AS tor --------------------- ③
 ON tpr.PNumber = tor.PNumber
 JOIN tItem AS tit --------------------- ④
 ON tpr.INumber = tit.INumber
 WHERE tit.IName = '공책' AND tor.ODate < CAST('20220321' AS TIMESTAMP)------ ⑤
 GROUP BY tit.IName ------ ⑥
) AS tBase
JOIN ------ ⑦
(
SELECT tit.IName, SUM(tpr.PCount) AS PCount ------ ⑧
 FROM tProduction AS tpr
JOIN tItem AS tit --------------------- ⑨
ON tpr.INumber = tit.INumber
WHERE tit.IName = '공책' AND tpr.PDate < CAST('20220321' AS TIMESTAMP) ----- ⑩
 GROUP BY tit.IName ----------- ⑪
) AS tBase2
ON tBase.IName = tBase2.IName
<해설>
① 제품명을 출력하기 위해 제품테이블인 tItem에서 제품명 컬럼인 IName을 가져오고 판매 가능한 재고량
을 출력하기 위해 총 생산량을 담당하는 서브쿼리 tBase2(별칭)의 PCount(생산량)에서 총 판매량을 담당
하는 서브쿼리 tBase(별칭)의 OCount를 빼준다.
② 제품명을 출력하기 위해 제품테이블인 tItem에서 제품명 컬럼인 IName을 가져오고 총 판매량을 출력하
기 위하여 생산테이블인 tProduction에서도 판매내역이 있는 PCount(생산량)를 가져온 후 합을 구하기
위해 SUM함수를 사용한다.
③ tOrder(주문) 테이블에 있는 ODate(판매일자)를 가져오기 위해 tProduction(생산) 테이블의 PNumber(생
산코드)와 tOrder(주문) 테이블의 PNumber(생산코드)를 JOIN한다.
④, ⑨ tItem(제품) 테이블에 있는 IName(제품명)을 가져오기 위해 tProduction(생산) 테이블의 INumber(제품코
드)와 tItem(제품) 테이블의 INumber(제품코드)를 JOIN한다.
⑤, ⑩ 문제의 조건인 공책을 가져오기 위해 제품테이블인 tItem에서 관련 컬럼인 IName과 비교한 후 문제의
조건인 2022-03-20 이전이기에 CAST를 사용하여 날짜가 이보다 작은 값을 가져온다.
⑥, ⑪ 그룹화 한 IName(제품명)을 기준으로 [SUM]함수를 사용하여 총 판매량(⑥)과 총 생산량(⑩)을 구한다
⑦ tBase(별칭) 서브쿼리에 있는 IName(제품명)과 OCount(총 판매량)와 tBase2(별칭) 서브쿼리에 있는
IName(제품명)과 PCount(총 생산량)를 가져오기 위해 tBase(별칭) 서브쿼리의 IName(제품명)과
tBase2(별칭) 서브쿼리의 IName(제품명)을 JOIN한다.
⑧ 제품명을 출력하기 위해 제품테이블인 tItem에서 제품명 컬럼인 IName을 가져오고 총 생산량을 출력하
기 위하여 생산테이블인 tProduction에서 생산량 컬럼인 PCount를 가져온 후 합을 구하기 위해 SUM함
수를 사용한다.
현재 재고량이 총 생산량 – 총 판매량이기에 총 생산량과 총 판매량을 가진 값들이 필요하여 생산량 데이터를
가지고 있는 테이블인 tProduction의 PCount와 판매 이력을 가지고 있는 테이블인 tOrder와 생산량을 가지고 있
는 테이블인 tProduction을 JOIN하여 판매량 데이터를 가지게 된 컬럼인 PCount를 SUM을 이용하여 각각 총 생
산량과 총 판매량으로 합산 후 두 테이블을 JOIN한 후 총 생산량에서 총 판매량 값을 빼주어 재고량을 구해주었
다.
<함수설명>
SUM( tpr.PCount )
- PCount의 데이터 타입이 숫자일 때 NULL인 값을 제외한 모든 값을 더해 리턴한다
CAST('20220321' AS TIMESTAMP)
- 텍스트타입인 '20220321'을 TIMESTAMP타입으로 형 변환한다.

<풀이 쿼리>
select *
  from titem;

select *
  from tproduction;
  
select *
  from torder;

select *
  from treturn;
  
with 
total_production as (
    select i1.iname  
         , sum(p1.pcount) as total_count
      from tproduction p1
     inner join titem i1
        on i1.inumber = p1.inumber
     where p1.pdate <= cast('20220320' as date)
       and i1.iname = '공책'
     group by i1.iname
) 
, order_production as (
    select i1.iname  
         , sum(p1.pcount) as order_count
      from tproduction p1
     inner join titem i1
        on i1.inumber = p1.inumber
     inner join torder o1
        on o1.pnumber = p1.pnumber 
     where o1.odate <= cast('20220320' as date)
       and i1.iname = '공책'
     group by i1.iname
) 
select t1.iname as 제품명
     , (t1.total_count - t2.order_count) as 제고량
  from total_production t1
 inner join order_production t2
    on t1.iname = t2.iname; 
    

  
select t1.iname as 제품명
     , (t1.total_count - t2.order_count) as 재고량
  from ( select i1.iname  
              , sum(p1.pcount) as total_count
           from tproduction p1
          inner join titem i1
             on i1.inumber = p1.inumber
          where p1.pdate <= cast('20220320' as date)
            and i1.iname = '공책'
          group by i1.iname ) t1
  inner join         
       ( select i1.iname  
              , sum(p1.pcount) as order_count
           from tproduction p1
          inner join titem i1
             on i1.inumber = p1.inumber
          inner join torder o1
             on o1.pnumber = p1.pnumber 
          where o1.odate <= cast('20220320' as date)
            and i1.iname = '공책'
          group by i1.iname ) t2
     on t1.iname = t2.iname;  
           

   
