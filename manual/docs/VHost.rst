VHost
========================

개별 서비스 설정(가상호스트 )에서 작성한 항목들을 실제 사용 여부를 결정한다. 해당 부분은 가상호스트 리스트 항목과 동일한 부분이며, 사용 설정된 가상호스트 항목은 실제 서비스시 활성화 되어 동작하게 된다. 사용 설정되지 않은 가상호스트 설정은 비활성화 된 상태로 설정 정보로서만이 존재한다.

::

    Default Path : /etc/pinix/conf/vhost
    Configuration File: [domain name]/vhost.json
    Configuration File: [domain name]/mime.types



1. Name
-------

Proxy 캐시 설정의 고유 이름이다. 해당 설정의 이름은 그 자체로서는 기능적
특성이 없으나 해당 설정의 고유 구분자로서 사용된다.

::

    - Keyword : name
    - Type    : json string
    - Location: location

\* Syntax

::

    {
        "name" : "default_location"
    }

2. URI\_TERMS
-------------

Proxy 설정의 URI 형식을 지정한다. 정규 표현식을 통한 URI 형식 분기가
가능하며, 지정한 URI 형식에 대한 반응 형식을 지정할 수 있다. 
\* Default
: URI 형식 요청이 완전히 일치하는 요청에 대해 반응한다. 
\* Sensitive :
URI 형식에서 대소문자를 구분 한다. 
\* Insensitive : URI 형식에서대소문자를 구분 한다.

::

    - Keyword : uri_terms
    - Type    : json string
    - Location: location

\* Syntax

::

    {
        "uri_terms" : "/proxy_pinix"
    }

3. Upper Case
-------------

클라이언트가 요청한 URI를 모두 대문자로 변경한다.

::

    - Keyword : uri_uppercase
    - Type    : json string
    - Location: location

\* Syntax

::

    {
        "uri_uppercase" : "off"
    }

4. Lower Case
-------------

클라이언트가 요청한 URI를 모두 소문자로 변경한다.

::

    - Keyword : uri_lowercase
    - Type    : json string
    - Location: location

\* Syntax

::

    {
        "uri_lowercase" : "off"
    }

5. Location Mode
----------------

PINIX 웹을 통한 설정에서 Location 모드와 Cache(proxy) 모드를 설정한다.

::

    -  Normal Mode : URI 전처리를 통해 내부적으로 다른 Location으로 분기
    -  Cache Mode : 클라이언트의 요청을 원본서버와 같은 다른 서버로 전달

5.1 Normal Mode
~~~~~~~~~~~~~~~

클라이언트의 요청을 URI 전처리를 통해 내부적으로 다른 Location으로
분기를 가능하게 한다. 이를 이용하면 클라이언트의 요청에 따라 다양한
응답을 가능하게 할 수 있다.

5.1.1 Streaming
~~~~~~~~~~~~~~

클라이언트가 캐싱되지 않은 컨텐츠를 요청했을 때, 캐싱이 완료되지 않아도
지연 없이 서비스를 제공받을 수 있다. ( 원본서버로부터 캐싱을 하면서
동시에 서비스를 제공 받는다. )

::

    - Keyword : streaming
    - Type    : json string
    - Location: location

\* Syntax

::

    {
        "streaming" : "off"          //<- Default : off
    }

5.1.2. TTL
~~~~~~~~~~

컨텐츠 요청에 대한 만료시간을 설정한다. 해당 기능을 ON으로 설정했을
경우, 기능이 활성화된다. 
\* Expire Time
    컨텐츠의 유효시간을 설정한다.

::

    - Keyword : expires
    - Type    : json string
    - Location: location

\* Syntax

::

    {
        "expires": "1d"
    }
    or
    {
        "expires": "max"
    }

5.1.3. Vary
~~~~~~~~~~~

컨텐츠의 Gzip 인코딩 기능 활성화 여부를 결정한다. ON으로 설정했을 경우,
해당 기능이 활성화된다.

::

    - Keyword : gzip_vary
    - Type    : json string
    - Location: location

\* Syntax

::

    {
        "gzip_vary" : "off",
    }

5.1.4. Rewrite Type
~~~~~~~~~~~~~~~~~~~

클라어인트의 요청에 대해 URI 전처리를 수행한다. URI 전처리 타입을
URI모드 PASS 두가지로 제공한다. URI모드의 경우 클라이언트의 요청을
정규표현식을 통해서 내부적으로 다른 Location으로 분기할 수 있다.
PASS모드의 경우 클라이언트의 요청을 정규표현식 없이 내부적으로 Proxy
이름을 기준으로 분기 할 수 있다.

::

    - Keyword : rewrite
    - Type    : json array
    - Location: location

\* Syntax

::

    {
        "rewrite" :                                    
        [
            {
                "type" : "pass",                       //<- URI or PASS
                "source" : "(.*)",
                "destination" : "default_location"
            }
        ]
    }
    or
    {
        "rewrite" :                                 
        [
            {
                "type" : "uri",                       //<- URI or PASS
                "source" : "(.*)",
                "destination" : "/pinix_proxy"
            }
        ]
    }

5.2 Cache Mode
~~~~~~~~~~~~~~

클라이언트의 요청에 다양한 캐싱 정책을 반영하여 원본서버와 같은 다른
서버로 요청을 전달하는데 목적이 있다.

5.2.1. Cache
~~~~~~~~~~~~

캐시 컨텐츠 제공에 필요한 기반 설정을 선택한다. 전역설정에서 지정한
프록시 항목의 캐시 키 존에 대한 설정을 적용 한다. 하나의 캐시 키 존은
다수의 Proxy 설정에 적용이 가능하다.

::

    - Keyword : cache_zone
    - Type    : json string
    - Location: location

\* Syntax

::

    {
        "cache_zone": "cache_one"
    }

5.2.2 Streaming
~~~~~~~~~~~~~~~

5.1.1 Streaming 과 동일

5.2.3. TTL
~~~~~~~~~~

캐시 컨텐츠의 만료 시간을 설정하여, 캐시 컨텐츠의 갱신 주기를 지정할 수
있다. \* Expire time : 캐시의 만료주기를 설정하며
초(s),분(m),시(h),일(d),월(M)에 대한 설정 가능 \* Response Code :
프록시되는 서버로부터 응답에 따른 캐시의 유효시간을 설정

::

    - Keyword : cache_valid & expires
    - Type    : json array & string
    - Location: location

\* Syntax

::

    {
        "cache_valid":                                  //<- TTL : 응답코드
        [
            "200 206 304 1y",
            "404 1m"
        ],
        "expires": "max"
    }

5.2.4. Vary
~~~~~~~~~~~

5.1.3 Vary와 동일
~~~~~~~~~~~~~~~~

5.2.5. Freshness Check
~~~~~~~~~~~~~~~~~~~~~~

캐시 된 컨텐츠의 최종 갱신 데이터 여부를 점검한다. ON으로 설정할 시 해당
기능이 활성화 된다.

::

    - Keyword : cache_revalid
    - Type    : json string
    - Location: location

\* Syntax

::

    {
        "cache_revalid" : "off"
    }

5.2.6. Intercept Errors
~~~~~~~~~~~~~~~~~~~~~~~

클라이언트 요청에 의한 HTTP 상태 코드에 따른 응답을 운영자가 임의로
지정한 별도 컨텐츠 응답으로 응답할 수 있도록 설정 할 수 있다. \* HTTP
::

    Status Code : HTTP 상태 코드 (ex: 404) 
    Redirect Target : /error\_page/404.html

::

    - Keyword : intercept_errors
    - Type    : json array
    - Location: location

\* Syntax

::

    {
        "intercept_errors" :                            
        [
            { "403" : "/403_default.jpg" }, 
            { "404" : "/404_default.jpg" },
            { "500 502 503 504" : "/50x_default.html" }
        ]
    }

5.2.7. Bypass
~~~~~~~~~~~~~

특정 캐시 컨텐츠 요청에 대하여, 캐싱 예외를 둘 수 있다. Bypass 기능을
활성화 한 후, Content-Type 지정하게 되면, 해당 Content-Type에 해당하는
컨텐츠는 캐싱 항목에서 제외된다. No Cache Bypass 기능을 설정할 시 해당
기능은 비활성화 된다.

::

    - Keyword : cache_bypass
    - Type    : json array
    - Location: location

\* Syntax

::

    {
        "cache_bypass" :       //<- cache_bypass_extension
        [
            "html",
            "css",
            "js"
        ]
    }

5.2.8. Set Header
~~~~~~~~~~~~~~~~~

요청헤더에 필드를 재정의 또는 추가 한다.

::

    - Keyword : set_header
    - Type    : json array
    - Location: location

\* Syntax ( Default )

::

    {
        "set_header" : 
        [
            "X-Forwarded-For $remote_addr",
            "Host $host",
            "If-Range $http_if_range",
            "Service-Type $http_service_type",
            "Cache-Backend $http_cache_backend"
        ]
    }

5.2.9. Ignore Headers
~~~~~~~~~~~~~~~~~~~~~

프록시 서버의 특정 응답헤더 필드의 처리를 하지 않는다.

::

    - Keyword : ignore_headers
    - Type    : json array
    - Location: location

\* Syntax ( Default )

::

    {
        "ignore_headers" :
        [
            "Set-Cookie",
            "Expires",
            "Cache-Control"
        ]
    }

5.2.10. Add Headers
~~~~~~~~~~~~~~~~~~~

클라이언트에게 보내는 HTTP응답헤더를 추가한다.

::

    - Keyword : add_header
    - Type    : json array
    - Location: location

\* Syntax ( Default )

::

    {
        "add_header" :
        [
            "X-Cache-Status $upstream_cache_status"
        ]
    }

5.2.11. Pass Headers
~~~~~~~~~~~~~~~~~~~~

금지된 응답헤더를 전송할 수 있다.

::

    - Keyword : permits_header
    - Type    : json string
    - Location: location

\* Syntax ( Default )

::

    {
        "permits_header" : "X-Accel-Redirect"
    }

5.2.12. Next Upstream
~~~~~~~~~~~~~~~~~~~~~

해당 에러 및 타임아웃이 발생했을 때 요청을 다음 원본서버(upstream)으로
전달한다.

::

    - Keyword : next_backend
    - Type    : json object
    - Location: location

\* Syntax ( Default )

::

    {
        "next_backend" :
        {
            "set" : "error timeout invalid_header"
        }
    }

5.2.13. Connect Timeout
~~~~~~~~~~~~~~~~~~~~~~~

프록시 서버와의 연결을 위한 시간 제한 정의 / 보통 75초 초과하지 않아야
함. 초(s),분(m),시(h),일(d),월(M)에 대한 설정이 가능하다.

::

    - Keyword : connect_timeout
    - Type    : json string
    - Location: location

\* Syntax ( Default )

::

    {
        "connect_timeout" : "300s"
    }

5.2.14. Send Timeout
~~~~~~~~~~~~~~~~~~~~

프록시 서버에 요청을 전송하기 위한 시간제한 설정
초(s),분(m),시(h),일(d),월(M)에 대한 설정이 가능하다.

::

    - Keyword : send_timeout
    - Type    : json string
    - Location: location

\* Syntax ( Default )

::

    {
        "send_timeout" : "300s"
    }

5.2.15. Read Timeout
~~~~~~~~~~~~~~~~~~~~

프록시 서버의 응답을 읽기 위해 시간 제한을 정의
초(s),분(m),시(h),일(d),월(M)에 대한 설정이 가능하다.

::

    - Keyword : read_timeout
    - Type    : json string
    - Location: location

\* Syntax ( Default )

::

    {
        "read_timeout" : "30s"
    }

5.2.16. Proxy Pass
~~~~~~~~~~~~~~~~~~

요청된 Proxy 설정의 URI정보를 Origin서버 혹은 사용자 정의 목적지를 향해
전달되도록 설정할 수 있다. 
::

    \* protocol : 요청 프로토콜을 지정 ( http or https ) 
    \* origin : 원본서버 혹은 사용자가 원하는 서버의 주소를 지정 
    \* $oriUri : 클라이언트가 요청한 URI 기본값

::

    - Keyword : backend 
    - Type : json object 
    - Location: location 

/* Syntax ( Default ) 
::

    {  
        "backend" :  
            {  
                "protocol" : "http",  
                "origin" : "default_origin`\ oriUri"
            } 
    }
