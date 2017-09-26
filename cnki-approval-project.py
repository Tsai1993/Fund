import requests
import pandas as pd
import datetime


session = requests.Session()
session.get("http://projects.cnki.net/Asynch/GetData.ashx?ac=ca&f=2&sc=ApprovalItem&_=1506340016953")


table = pd.DataFrame()
for i in range(1,5673):
    url = "http://projects.cnki.net/Asynch/GetData.ashx?id=ApprovalItem&sc=ApprovalItem&cf=/CoreResources/ConfigFolder/ListView/ListView.xml&ps=100&ac=Page&cp={}&_=1506338765352".format(i)
    r = session.get(url)
    print(url)
    table = table.append(pd.read_html(r.content, encoding='gbk18030'))
    print(i)

table2 = table.iloc[:,0:7]

date = datetime.datetime.now()
name = 'cnki-approval-project-' + '-'.join([str(date.year), str(date.month), str(date.day)]) + '.csv'
table2.to_csv(name, index=False)
