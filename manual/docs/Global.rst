Global 
===============
PINIX 기본 동작에 필요한 전역 환경 설정을 지정하는 항목이며, 해당 항목을 통해 지정된 설정은 특정 서비스에 종속되지 않고 서비스 전역에 반영된다.

::

    - Default Path : /etc/pinix/conf
    - Configuration File: pinix.json

::

    - Keyword : global & main
    - Type    : json object

\* Main Syntax

::

    {
        // Pinix Global Section
        "[global-key-1]" : "[string]",
        "[global-key-2]" : "[string]"

            ...

        // Pinix Main Conf Section
        "main" :
        {
            ...
        }
    }


1. Global Process
-----------------

PINIX 기본동작에 필요한 사용자 및 로그형식 등의 항목을 설정하는
그룹이다.

1.1 PINIX Process User
~~~~~~~~~~~~~~~~~~~~~~

리눅스 기반 시스템에서 pinix 프로세스의 사용자 이름을 지정한다. 사용자의
이름을 지정 후, 캐시 솔루션 정보 RELOAD(또는 RESTART) 작업을 수행할 시
PINIX의 Woker process는 지정된 사용자의 이름으로 재 실행된다.

::

    - Keyword : user 
    - Type    : json string
    - Location: global

\* Syntax

::

    {
        "user" : "root"
    }

1.2 Worker Process Count
~~~~~~~~~~~~~~~~~~~~~~~~

PINIX를 구성하는 Woker Process의 수를 지정한다. 기본값은 ‘auto’이며
PINIX에서 H/W성능을 고려한 최적의 수로 기동한다. 운영자가 직접 입력할
경우 일반적으로 CPU-Core의 배수 값을 권장한다.

::

    - Keyword : worker_processes 
    - Type    : json string
    - Location: global

\* Syntax

::

    {
        "worker_processes" : "auto"
    }
    or
    {
        "worker_processes" : "8"    //<- CPU-Core x 2
    }

1.3 Access log File Path
~~~~~~~~~~~~~~~~~~~~~~~~

PINIX의 로그경로 및 파일이름을 지정한다.

::

    - Keyword : access_log 
    - Type    : json string
    - Location: main, vhost

\* Syntax

::

    {
        "access_log" : "/var/log/pinix/access.log"
    }

1.4 Log format
~~~~~~~~~~~~~~

각 서비스 모니터링에 필요한 로그 출력 형태를 설정한다. Log Format
Group을 추가/수정하여 세부적으로 로그를 남길 항목들을 설정 할 수 있으며,
지정한 로그 항목들의 노출 순서를 지정할 수 있다.

.. image:: ../images/manual/using_logformat.gif
   :target: ../images/manual/using_logformat.gif
   :align: center


::

    - Keyword : log_format
    - Type    : json array
    - Location: main

\* Syntax

::

    "log_format" :
    [
        // Array - 0
        {
            "name" : "main",
            "values" :
            [
                "milliseconds",
                "request_time",
                "remote_addr",
                "upstream_cache_status",
                "status",
                "bytes_sent",
                "request_method",
                "url",                          //<- http://Request URL
                "remote_user",
                "sent_http_content_type",
                "http_user_agent",
                "document_uri",
                "http_referer",
                "http_range",
                "http_cache_hierarchy",
                "http_cache_backend",
                "sent_http_content_length",
                "upstream_addr",
                "upstream_response_time",
                "request_length",
                "connection",
                "connection_requests",
                "pipe",
                "time_local"
            ]
        },
        // Array - 1
        {
            "name" : "user_log",
            "values" : [ "milliseconds", "request_time", "status", "bytes_sent" ]
        }
    ]


2. Proxy
--------

각 서비스(가상호스트)에서 사용할 캐싱 서비스 영역 및 설정을 관리한다.

2.1 Temporary Cache Path
~~~~~~~~~~~~~~~~~~~~~~~~

캐싱 중인 컨텐츠는 임시로 저장되는데, 그 경로를 설정한다

::

    - Keyword : temp_path
    - Type    : json string
    - Location: main

\* Syntax

::

    {
        "temp_path" : "/data/pinix/proxy_temp_dir"
    }

2.2 Cache Path List & Config
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

서비스 캐시의 디스크 경로를 지정한다. 캐싱이 완료된 컨텐츠는
임시경로에서 캐시경로로 이동하는데, 그 경로를 설정한다. 경로로 지정되는
디스크 경로는 PINIX가 읽고 쓸 수 있는 권한이 있어야 한다. 

::

    - path : 캐싱된 컨텐층의 경로 설정 
    - Keyzone Name : 해당 캐시 저장 영역의 고유이름 설정 
    - Key hash size : 캐시 대상의 키 값 사이즈를 설정 
    - inActive :캐시 설정파일의 활성화 시간을 설정 
    - Max Size : 캐시 저장 영역의 물리적 허용 디스크 크기를 설정

::

    - Keyword : cache_path
    - Type    : json array
    - Location: main

\* Syntax

::

    {
        "cache_path" :
        [
            // Array - 0
            {
                "path" :"/data/pinix/proxy_cache_dir",
                "levels" : "1:2",                           //<- 기본값
                "keyszone_name" : "cache_one",      
                "keyshash_size" : "500m",
                "inactive" : "1d",
                "max_size" : "7000g"
            }, 
            // Array - 1  
            {
                ...
            }
        ]
    }


3. Server Access Control
------------------------

PINIX 서버의 접근을 허용/거부 할 IP를 설정한다. IP 대신 ``all``\ 을
지정하면 모든 접근 허용 및 거부를 의미한다.

::

    - Keyword : allow, deny
    - Type    : json array
    - Location: main, vhost

\* Syntax

::

    {
        "allow" :
        [
            "169.126.123.1",
            "169.126.123.2",

            "192.168.1.0/24"
        ],
        "deny" :
        [
            "all"
        ]
    }


4. Cluster
----------

PINIX는 클러스터 구성을 통해 안정성과 성능이 한 층 강화된 서비스를
제공할 수 있다. PINIX 캐시 솔루션은 캐시에 대한 요청시 해당 메타데이터
스토리지에 운용중인 PINIX 캐시 솔루션의 부하 정보 등을 종합하여 최적의
캐시 컨텐츠 제공 경로를 지정하여 운용된다. 


    - Cluster(cluster\_mode)
          PINIX의 클러스터 기능을 활성화 할지 여부를 결정 
    - Metastore Server Address(meta\_store)
          PINIX의 서비스(Cached Contents, Load Info)정보가보관되어 있는 메타DB 서버의 IP/Port를 설정 
    - Synchronize Time(synctimesec)
          PINIX 클러스터, 즉 여러 노드에서 실제 서비스되고 있는 정보(Contents)와 
          메타DB에 저장되어 있는 서비스(Cached Contents)정보에 대한 동기화 시간을 설정. 
          동기화 시간이 짧을수록 클러스터로 구성된 PINIX의 부하와 같은 운용 정보가 실시간에 
          가까워지나, 동기화 시간이 짧을수록, 클러스터로 구성된 서버의 수가 많을수록 
          동기화 자체가 부하로 작용함에 주의해야 한다.

::

    - Keyword : cluster
    - Type    : json object
    - Location: main

\* Syntax

::

    {
        "cluster" :
        {
            "cluster_mode" : "off",                     //<- Default : off
            "meta_store" : "127.0.0.1:8881",
            "synctimesec" : "60"
        }
    }

