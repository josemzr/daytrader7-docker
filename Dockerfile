FROM websphere-liberty:webProfile7

COPY server.xml /config/
COPY daytrader-ee7.ear /config/dropins/
COPY /Daytrader7SampleDerbyLibs	/opt/ibm/wlp/usr/shared/resources/

RUN installUtility install --acceptLicense defaultServer


