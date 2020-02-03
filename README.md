# docker file for 
Docker image for PHP7.4 and Laravel with Apache.

Run it like you would:

docker run -p 80:80 -p 443:443 vinitatdocker/laravel-php7.4-apache2.x

This will start a PHP server with the container port 80 / 443. You will need to map the port to your host manually. How it builds

This uses the latest Official Ubuntu Bionic and PHP7.4 Docker image from ppa:ondrej .

Docker Hub compiles the initial images with handful PHP extensions, and then stores the final image which can be downloaded from Docker Hub. Then deletes all packages except for the shared libraries needed by some extensions to work. Extensions ready to use

I took the job to compile and install everything you would want to use Laravel with php7.4. CExtension Description bcmath Calculate any number of any precision while representing them as strings bz2 Read and write bzip2 (.bz2) compressed files exif Work with image meta data. gettext NLS (Native Language Support) API to internationalize your application. intl Internationalization extension to perform various locale-aware operations. ldap Lightweight Directory Access Protocol to access "Directory Servers". opcache Cache your application in memory instead of compiling it on every request. pcntl Call commands and processes. posix Standard for using POSIX APIs. Who said regex? pdo_mysql Lightweight, consistent interface for accessing MySQL databases in PHP. pdo_pgsql Lightweight, consistent interface for accessing PostgreSQL databases in PHP. pdo_sqlite Lightweight, consistent interface for accessing SQLite databases in PHP. soap Write SOAP Servers and Clients. sockets Low-level interface for socket based communication functions. tidy Binding for the Tidy HTML to traverse and manipulate HTML, XHTML, and XML documents. xmlrpc Write XML-RPC servers and clients. zip Transparently read or write ZIP compressed archives.

PECL Extensions Extension Description igbinary PHP serializer good for heavy reads and low writes. Like sessions. redis Redis client interface for Redis servers. Has igbinary for serialization. amqp Advanced Message Queuing Protocol for passing messages between applications gmagick The swiss army knife of image processing. Multi-threaded. xdebug Your favorite PHP Debugger.

