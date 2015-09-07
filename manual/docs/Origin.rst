Origin
======

1. Name
-------

원본서버 이름을 설정한다. 이 이름은 가상호스트의 프록시설정에 그대로
반영할 수 있다.

::

    - Keyword : name 
    - Type    : json string
    - Location: origin

\* Syntax

::

    {
        "name" : "default_origin"
    }

2. Schedule
-----------

다수의 원본서버에 요청할 때 다양한 스케줄링을 설정할 수 있다. 서버로
보내는 모든 요청은 라운드로빈(round-robin) 방식으로 백엔드 서버에 전달
한다. 

    - rr 
        기본값이며, 등록된 서버를 라운드 로빈 형태로 서비스. 
    - fair 
        단순한 가중 최소 접속 라운드로빈으로 활성화된 접속자 수가 가장적은 서버를 RR방식으로 선택하여 요청. 
    - fair no\_rr (no roun-robin)
        라운드로빈 방식을 사용을 하지않고, 부하 양에 따라 다수의 백엔드를 배정하는 경우에 적용.이 방식은 필요한 만큼의 백엔드를 사용할 수 있도록보장(권장설정 값) 
    - fair weight\_mode=idle no\_rr 
        최소한의 백엔드 서버 풀 안에서 부하분산을 수행. 
    - fair weight\_mode=peak 
        백엔드 서버가 더이상의 요청을 처리를 못한 busy 상태일 경우 클라이언트에 502 에러로 응답.

::

    - Keyword : schedule
    - Type    : json string
    - Location: origin

\* Syntax

::

    {
        "schedule" : "rr"    //<- fair | fair no_rr | fair weight_mode=idle no_rr | fair weight_mode=peak
    }

3. Server
---------

실제 서비스에 반영할 원본서버 주소를 설정한다. 원본서버 설정 시 장애에
적절한 대응을 위한 다양한 정책을 지정할 수 있다.

    -  weight=number
        백엔드 서버에 대한 가중치 설정기본 설정값 = 1
    -  max\_fails=number
        요청실패회수에 대해서 임계치를 지정을 하고, 해당회수에 도달하면 작동하지 않는 서버로 간주기본 설정값 = 1
    -  max\_timeout=number
        설정한 시간동안 요청이 성공을 하지 못할 경우작동하지 않는 서버로 간주기본 설정값 = 10s
    -  backup
        primary서버가 사용불가시 backup서버에서 요청을 수행. \`\`\`

::

    -  Keyword : server
    -  Type : json array
    -  Location: origin

/* Syntax
::
    { "server" : 
        [ 
            // Array - 0 
            { "host" : "210.181.96.63" }, 
            // Array -1 
            { 
                "host" : "210.181.96.26", 
                "policy" : 
                    { 
                        "weight" : "5",
                        "max\_fails" : "3", 
                        "fail\_timeout" : "5s", 
                        "sub\_policy" : "none" //<- "none \| backup \| down" 
                    } 
            }
        ] 
    }
