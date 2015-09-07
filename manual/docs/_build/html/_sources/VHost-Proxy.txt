Virtual Host Proxy
=============================================
클라이언트의 요청을 원본서버 또는 다른서버로 전달하기 위한 설정을 관장한다.

::

    - Keyword : location
    - Type    : json array
    - Location: vhost

\* Syntax (Default)
::

    {
        "vhost" :
        {
        ...

        "location" :
            [
                //<- Array - 0
                {
                    ...
                },
                //<- Array - 1
                {
                    ...
                }
            ]
        }
    }


1. 가상호스트 목록
-----------------

PINIX의 가상호스트(도메인별 서비스) 목록을 관리한다. 가상호스트(도메인별
서비스)의 추가, 삭제, 복제 기능을 수행할 수 있다. 삭제 기능은 각
가상호스트 설정 내부 항목에서 지원한다.

::

    -  추가 : 신규 가상호스트 설정을 추가한다.
    -  적용 : 가상호스트를 서비스에 반영할지 여부를 결정한다..
    -  복제 : 기존 가상호스트 설정 정보를 다른 도메인 형식으로 서비스할 수 있다. 단, 암호화 URL 항목은 복제대상에서 제외된다.

2. Process
----------

가상호스트 운영에 필요한 기본적인 정보를 설정한다. 

2.1 가상호스트
~~~~~~~~~~~~~
Domain 가상호스트에 지정될 서비스 도메인 정보 가상호스트에서 서비스할
도메인 정보를 설정한다. 도메인 정보는 운영상 안정성을 목적으로 쉬운 접근
/ 수정을 허용하지 않는다. 때문에 가상호스트 추가, 복제 시에만 설정이
가능하고, 이 후 수정은 불가능 하다.

::

    - Keyword : domain
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "domain" : "vhost domain"
    }

2.2 Service Port
~~~~~~~~~~~~~~~~

가상호스트에서 서비스할 포트를 설정한다.
잘 알려진 포트(Well Known port)의 경우 사용이 제한되며, 80 포트만을
예외로 지정할 수 있다.

::

    - Keyword : listen
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "listen" : "80"
    }

2.3 Record 404 error log
~~~~~~~~~~~~~~~~~~~~~~~~

Page Not Found(404) 상태 코드 발생 시, 로그를 기록할 지 여부를 결정한다.
ON일 경우 해당 기능이 활성화 된다.

::

    - Keyword : log_not_found
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "log_not_found" : "on"
    }

2.4 Default Type
~~~~~~~~~~~~~~~~

PINIX의 요청 응답시, 요청한 클라이언트에서 기본적으로 동작할
Content-Type을 정의한다.

::

    - Keyword : default_type
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "default_type" : "application/octet-stream"
    }

2.5 Error Log File Path
~~~~~~~~~~~~~~~~~~~~~~~

에러로그를 기록할 파일경로를 설정한다.

::

    - Keyword : error_log
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "error_log" : "/var/log/pinix/pinix_status.log"
    }

2.6 Common Log File Path
~~~~~~~~~~~~~~~~~~~~~~~~

서비스 로그를 기록할 파일경로를 설정한다.

::

    - Keyword : access_log
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "access_log" : "/var/log/pinix/access.log"
    }

2.7 Access log format type
~~~~~~~~~~~~~~~~~~~~~~~~~~

전역설정에서 정의한 로그포멧 형태들 중 하나를 선택하여, 서비스 로그에
반영한다.

::

    - Keyword : access_log_type
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "access_log_type" : "main"
    }

3. HTTPS
--------

SSL 보안 인증서를 통한 요청에 대한 처리를 정의 한다. 

3.1 HTTPS Mode
~~~~~~~~~~~~~~
SSL 보안 인증서를 통한 요청 기능 활성화 옵션 ON을 선택할 경우 해당
기능이 활성화 된다.

3.2 Port
~~~~~~~~

SSL 보안 인증서 프로토콜에 대한 서비스 포트를 지정한다. (기본값 443)

::

    - Keyword : listen
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "listen" : "443 ssl"
    }

3.3 Protocols
~~~~~~~~~~~~~

SSL 인증서 보안 프로토콜의 버전을 지정한다. 프로토콜 지정에 있어 다음과
같은 버전 매칭 정보를 참조한다.

::

    -  TLSv1 = SSL3.1
    -  TLSv1.1 = SSL3.2
    -  TLSv1.2 = SSL3.3

::

    - Keyword : ssl_protocols
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "ssl_protocols" : "TLSv1 TLSv1.1 TLSv1.2"
    }

3.4 Certificate
~~~~~~~~~~~~~~~

SSL 인증서 파일 경로를 설정한다.

::

    - Keyword : ssl_certificate
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "ssl_certificate" : "/etc/pinix/cert/pinix_cert.pem"
    }

3.5 Certificate Key
~~~~~~~~~~~~~~~~~~~

SSL 인증서 키 파일 경로를 설정한다.

::

    - Keyword : ssl_certificate_key
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "ssl_certificate_key" : "/etc/pinix/cert/pinix_key.pem"
    }

3.6 Session Timeout
~~~~~~~~~~~~~~~~~~~

https 세션에 대한 타임아웃을 설정한다.

::

    - Keyword : ssl_session_timeout
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "ssl_session_timeout" : "5m"
    }

4. Client
---------

4.1 ETAG
~~~~~~~~

요청한 URL이 이전에 요청했던 컨텐츠와 동일 여부 확인하여 컨텐츠의 변경
여부를 검사한다. ON으로 설정했을 시, 해당 기능이 활성화된다.

::

    - Keyword : etag
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "etag" : "on"
    }

4.2 Falsification Check
~~~~~~~~~~~~~~~~~~~~~~~

Cache 대상 컨텐츠의 변조여부에 대한 점검 기능을 활용할지 여부를
결정한다. ON으로 설정했을 시, 해당 기능이 활성화된다.

::

    - Keyword : falsification_check
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "falsification_check" : "off"
    }

4.3 Client Response Header
~~~~~~~~~~~~~~~~~~~~~~~~~~

PINIX에 대한 클라이언트 요청 헤더를 재설정한다. 응답 헤더의 설정에 따라
캐시를 요청하는 클라이언트의 정의된 후속 동작을 지정할 수 있다.

::

    - Keyword : add_header
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "add_header" : "X-Location \"$1.$2\"",
    }

4.4 Client Body Timeout
~~~~~~~~~~~~~~~~~~~~~~~

client가 보낸 요청 바디에 대한 읽기 제한 시간을 설정한다.

::

    - Keyword : client_body_timeout
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "client_body_timeout" : "300s"
    }

4.5 Client Header Timeout
~~~~~~~~~~~~~~~~~~~~~~~~~

client가 보낸 요청 헤더에 대한 읽기 제한 시간을 설정한다.

::

    - Keyword : client_header_timeout
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "client_header_timeout" : "300s"
    }

4.6 Send Timeout
~~~~~~~~~~~~~~~~

클라이언트에 대한 응답 전송 제한 시간을 설정 한다.

::

    - Keyword : send_timeout
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "send_timeout" : "300s"
    }

4.7 Keepalive Timeout
~~~~~~~~~~~~~~~~~~~~~

클라이언트가 PINIX에 대한 접근 방식 중, HTTP Keepalive 옵션에 대한 최대
유지 시간을 지정한다. 지정된 타임아웃 시간 동안 연결은 유지되며,
타임아웃 시간을 초과할 시 PINIX은 연결을 해제한다.

::

    - Keyword : keepalive_timeout
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "keepalive_timeout" : "30 30"
    }

4.8 Keepalive Requests
~~~~~~~~~~~~~~~~~~~~~~

?) PINIX이 클라이언트 Keepalive 연결 방식을 최대 수용할 수 있는 수를
지정한다. ?) 하나의 keepalive 접속을 통해 서비스되는 최대 요청 수 (기본값 100)

::

    - Keyword : keepalive_requests
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "keepalive_requests" : "100"
    }

5. Proxy
--------

Virtual Host Proxy

6. Secure URL
-------------

해당 가상호스트 정보를 기반으로 요청되는 URI에 대해서, 암호화 요청이
가능하도록 설정할 수 있다. 암호화 요청이란, URI의 형상이 통상적으로
의미를 지니지 않은 특정 암호화 알고리즘을 통해 난독화 되어 제공되는
형상의 URI를 일컫는다. 설정시 생성 완료된 가상호스트에 대해서만 해당
기능을 활성화 할 수 있음에 주의해야 한다.

6.1 Secure URL
~~~~~~~~~~~~~~

암호화 URI 사용 여부를 결정한다. ON으로 설정할 시, 해당 기능이 활성화
된다.

6.2 Secure Algorithm Type
~~~~~~~~~~~~~~~~~~~~~~~~~

URI의 암호화 알고리즘 형태를 지정한다.

::

    - Keyword : pinix_auth_algorithm
    - Type    : json array
    - Location: vhost, secure_url

\* Syntax

::

    {
        "pinix_auth_algorithm" : "rsa"
    }

6.3 Secure URL Character Case
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

요청 받은 암호화 URI에 대하여, URI를 대문자/소문자 전환하여 처리할
것인지를 지정한다. None으로 설정할시 해당 기능은 비활성화 되어,
클라이언트에서 요청한 URI를 그대로 처리에 사용하게 된다.

::

    - Keyword : pinix_api_letter_case
    - Type    : json array
    - Location: vhost, secure_url

\* Syntax

::

    {
        "pinix_api_letter_case" : "lower"
    }

6.4 Callback Domain
~~~~~~~~~~~~~~~~~~~

가상호스트의 도메인 설정과는 별도로 해당 암호화 URL에 대한 처리를 할 수
있는 별도의 도메인 정보를 할당한다. PINIX은 해당 항목을 통해 지정된
도메인에 대한 요청은 모두 암호화 URL에 대한 요청이라고 판단되고
처리된다.

::

    - Keyword : pinix_api_callback_domain
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "pinix_api_callback_domain" : "secure_url.com"
    }

6.5 Callback File Path
~~~~~~~~~~~~~~~~~~~~~~

암호화 URL에 대한 도메인 요청 항목서, 해당 암호화 URL을 처리할 CGI/WSGI
파일의 패스를 지정한다. 해당 CGI/WSGI 파일의 처리를 통해 암호화 URL은
최종적으로 복호화된다.

::

    - Keyword : pinix_api_callback_file
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "pinix_api_callback_file" : "/callback_file.php"
    }

6.6 URL forwarding results
~~~~~~~~~~~~~~~~~~~~~~~~~~

복호화 된 암호화 URL을 전달할 결과 파일 패스를 지정한다.

::

    - Keyword : pinix_url_forwarding
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "pinix_url_forwarding" : "/proc"
    }

6.7 Secure URL Key
~~~~~~~~~~~~~~~~~~

암호화 URL의 Key가 될 패스워드 값을 지정한다. 해당 값을 지정한 후,
“Create Secure URL Key” 버튼을 통해, 실질적으로 사용될 암호화 URL Public
Key, Private Key 등이 발급된다.

6.8 Secure URL Value
~~~~~~~~~~~~~~~~~~~~

Secure URL Key를 통해 발급된 암호화 URL 인증서 정보.

7. Server Access Control
------------------------

7.1 Server Access Control
~~~~~~~~~~~~~~~~~~~~~~~~~

PINIX 서버의 접근을 허용/거부 할 IP를 설정한다. IP 대신 ‘all’을 지정하면
모든 접근 허용 및 거부를 의미한다.

::

    - Keyword : allow, deny
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
            "allow" :
            [
              "192.168.1.0/24"
              "222.168.1.0/24"
            ],
            "deny" :
            [
              "all"
            ]
    }

7.2 Bandwidth
~~~~~~~~~~~~~

해당 VHost 정보의 최대 대역폭을 지정한다.

::

    - Keyword : limit_rate
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "limit_rate" : "30m"
    }

7.3 Bandwidth After
~~~~~~~~~~~~~~~~~~~

limit\_rate\_after 1m; - 이 size만큼 응답한 이후에 limit\_rate 속도로
응답함

::

    - Keyword : limit_rate
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "limit_rate_after" : "0"    
    }

7.4 Resolver
~~~~~~~~~~~

PINIX가 채택할 네임서버를 명시적으로 지정

::

    - Keyword : resolver
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "resolver" : "127.0.0.1"
    }

7.5 Resolver Timeout
~~~~~~~~~~~~~~~~~~~~

네임서버 질의응답 타임아웃 설정

::

    - Keyword : limit_rate_after
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "resolver_timeout" : "30s"
    }

7.6 Cache Regex Purge
~~~~~~~~~~~~~~~~~~~~~

정규표현식에 따른 캐시 퍼지(캐시 삭제 및 갱신) 기능 활성화 여부를
결정한다. ON 했을 시, 해당 기능은 활성화 된다.

::

    - Keyword : cache_rpurge
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "cache_rpurge" : "on"
    }

8. Compression
--------------

가상호스트 형식으로 제공되는 컨텐츠에 대한 Gzip 압축 파일 인코딩에 대한
활성화 여부를 지정할 수 있다.

8.1 GZip
~~~~~~~~

요청 받은 컨텐츠를 Gzip 압축 형식으로 압축하여 응답한다.

::

    - Keyword : gzip
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "gzip" : "on"
    }

8.2 Gzip Static
~~~~~~~~~~~~~~~

요청 때마다 실시간으로 문서를 압축하는 대신 미리 Gzip 형식으로 압축해
놓은 문서를 전송할 수 있다.

::

    - Keyword : gzip_static
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "gzip_static" : "on"
    }

8.3 Gzip Disable
~~~~~~~~~~~~~~~~

HTTP 헤더에 포함된 클라이언트 에이젼트 정보를 토대로, Gzip 압축 형식을
진행하지 않을 예외 에이젼트 정보를 지정한다. 정규표현식을 통한 에이젼트
정보 지정이 가능하다. user-agent를 확인하여 해당 제품의 버전일 경우 압축
안함.

::

    - Keyword : gzip_disable
    - Type    : json array
    - Location: vhost

\* Syntax

::

    {
        "gzip_disable" : "MSIE [1-6]\\.(?!.*SV1)"
    }

9. Mime Types
-------------

PINIX의 가상호스트에서 처리 가능한 Mime Type 정보를 지정한다.

::

    - Keyword : 
    - Type    : pinix mime type
    - Location: vhost

\* Syntax

::

    types {

        text/html                             html htm shtml;
        text/css                              css;
        text/xml                              xml;
        image/gif                             gif;
        image/jpeg                            jpeg jpg;
    }
