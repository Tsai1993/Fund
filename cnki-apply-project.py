import requests
import pandas as pd
import datetime


session = requests.Session()
session.get("http://projects.cnki.net/Asynch/GetData.ashx?ac=ca&f=1&sc=CanApply&_=1506348842873")


table = pd.DataFrame()
for i in range(1,140):
    url = "http://projects.cnki.net/Asynch/GetData.ashx?id=CanApply&sc=CanApply&cf=/CoreResources/ConfigFolder/ListView/ListView.xml&ps=100&ac=Page&cp={}&_=1506348842874".format(i)
    r = session.get(url)
    print(url)
    table = table.append(pd.read_html(r.content, encoding='gbk18030'))
    print(i,table.head())

table2 = table.iloc[:,0:5]

date = datetime.datetime.now()
name = 'cnki-apply-project-' + '-'.join([str(date.year), str(date.month), str(date.day)]) + '.csv'
table2.to_csv(name, index=False)