# daytrader7-docker
Dockerized version of IBMs DayTrader benchmark

To build it:

docker build -t daytrader .

To run it:

docker run -d -p 9082:9082 daytrader
