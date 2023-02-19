7. UNION
제품이 한번이라도 주문됐거나, 반품이 한번이라도 발생한 월의 정보를 알아보려고한다. 위, 조건에 해당하는 월들을 중복을 제거하고 출력하시오.

<정답 쿼리>
SELECT TO_CHAR(tor.ODate, 'MM') AS 주문_및_반품월 ---------- ①
FROM tOrder AS tor
GROUP BY TO_CHAR(tor.ODate, 'MM') ----------- ②
UNION ------------ ③
SELECT TO_CHAR(tre.RDate, 'MM') ------------ ④
FROM tReturn AS tre
GROUP BY TO_CHAR(tre.RDate, 'MM') ------------- ⑤
<해설>
① ODate(주문일)를 출력하기 위해 주문테이블인 tOrder에서 주문일 컬럼인 ODate를 가져오고
문제의 조건인 월별로 출력하기 위해 TO_CHAR함수를 사용하여 월 형태로 형식을 변경한다.
② TO_CHAR함수를 사용하여 월 형태로 형식을 변경한 Odate(주문일)를 GROUP BY를 사용하여 그룹화한다
③ 위의 쿼리와 아래의 쿼리를 UNION을 사용하여 합친다.
④ RDate(반품일)를 출력하기 위해 반품테이블인 tReturn에서 반품일 컬럼인 RDate를 가져온다.
문제의 조건인 월별로 출력하기 위해 TO_CHAR함수를 사용하여 월 형태로 형식을 변경한다.
⑤ TO_CHAR함수를 사용하여 월 형태로 형식을 변경한 RDate(반품일)를 GROUP BY를 사용하여 그룹화
한다.
<함수설명>
TO_CHAR(tor.ODate, 'MM') , TO_CHAR(RDate,'MM')
- 첫번째 파라미터인 ODate, RDate는 Timestamp타입이고, 두번째 파라미터인 ‘MM’ 포맷에 맞춰 ‘월’의
텍스트타입으로 리턴한다.

<풀이 쿼리>
select *
  from torder;

select *
  from treturn;
  
select temp_month as 주문_및_반품월
  from (
            select to_char(odate, 'MM') as temp_month
              from torder
        ) t1 
 group by t1.temp_month    
    
 union
 
 select temp_month
   from (
            select to_char(rdate, 'MM') as temp_month
             from treturn 
        ) t1 
 group by t1.temp_month    
  
select t2.temp_month as 주문_및_반품월
  from (
            select temp_month
              from (
                        select to_char(odate, 'MM') as temp_month
                          from torder
                    ) t1 
             group by t1.temp_month    
            
             union all
             
            select temp_month
              from (
                        select to_char(rdate, 'MM') as temp_month
                          from treturn 
                    ) t1 
             group by t1.temp_month  
        ) t2
 group by t2.temp_month; 