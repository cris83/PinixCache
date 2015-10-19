Monitoring
======

1. Dashboard
-------

.. image:: ../images/manual/dashboard.png
    :target: ../images/manual/dashboard.png
    :align: center


피닉스 모니터링은 피닉스 캐시 서버에 대하여 요청에 대한 모든 현황을 파악할 수 있도록 리스팅 되어 제공됩니다.
시간대별로 1일, 한달, 1년의 데이터를 살펴볼 수 있습니다.

상단의 청색으로 강조 표시되어 있는 도메인은 요청이 들어온 도메인 중, 가상 호스트 도메인 정보에 등록이 되어있는 정규 등록 도메인입니다.
그 외의 강조 표시가 되어있지 않은 도메인은 가상 호스트 도메인 정보에 등록되어있지 않은 비정규 요청 도메인입니다.

요청이 들어온 데이터는 HIT, MISS, 1XX, 2XX, 3XX, 4XX, 5XX 및 SENT bps(Bit per second), RECV bps로 정보 제공됩니다.
해당 데이터는 기간별 누적 데이터임에 주의해주십시오.

    - HIT, MISS
        컨텐츠 요청에 대한 캐시 응답 결과 정보입니다.
    - 1XX, 2XX, 3XX, 4XX, 5XX
        컨텐츠 요청에 대한 응답 HTTP 상태코드 카운트 수치입니다.
    - SENT bps, RECV bps
        전송 및 수신에 대한 bps(bit per second)에 대한 수치입니다. 


2. Details
-----------

.. image:: ../images/manual/domaingraph_details.png
    :target: ../images/manual/domaingraph_details.png
    :align: center

도메인의 상세정보 열람이 가능합니다.
해당 정보는 대시보드 정보에서 선택된 도메인에 대하여 상세 히스토리 정보를 제공합니다.
